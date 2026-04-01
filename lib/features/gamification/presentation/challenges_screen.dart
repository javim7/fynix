import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/dev/mock_data.dart';
import 'package:fynix/core/widgets/fynix_card.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  bool _showEvents = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── App bar ───────────────────────────────────────────────────
          SliverAppBar(
            backgroundColor: AppColors.obsidian,
            floating: true,
            title: const Text('Retos'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: _SegmentToggle(
                showEvents: _showEvents,
                onChanged: (v) => setState(() => _showEvents = v),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.xl,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                _showEvents ? _buildEvents() : _buildChallenges(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildChallenges() {
    return [
      // Header
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.flameCoral.withAlpha(28),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.local_fire_department_rounded,
              color: AppColors.flameCoral,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Desafíos activos', style: AppTypography.h4),
              Text(
                'Completa retos para ganar XP y Embers',
                style: AppTypography.bodySmall,
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: AppSpacing.md),
      ...kMockChallenges.asMap().entries.map(
        (e) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: _ChallengeCard(challenge: e.value)
              .animate(delay: (70 * e.key).ms)
              .fadeIn(duration: 280.ms)
              .slideY(begin: 0.06, end: 0, duration: 280.ms),
        ),
      ),
    ];
  }

  List<Widget> _buildEvents() {
    final races = kMockEvents.where((e) => e.isRace).toList();
    final community = kMockEvents.where((e) => !e.isRace).toList();

    return [
      // ── Carreras destacadas ───────────────────────────────────────────
      Text('Carreras', style: AppTypography.h4),
      const SizedBox(height: AppSpacing.sm),
      ...races.asMap().entries.map(
        (e) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: _RaceCard(event: e.value)
              .animate(delay: (70 * e.key).ms)
              .fadeIn(duration: 280.ms)
              .slideY(begin: 0.05, end: 0, duration: 280.ms),
        ),
      ),
      const SizedBox(height: AppSpacing.xs),

      // ── Eventos comunitarios ──────────────────────────────────────────
      Text('Retos con causa', style: AppTypography.h4),
      const SizedBox(height: AppSpacing.sm),
      ...community.asMap().entries.map(
        (e) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: _CommunityEventCard(event: e.value)
              .animate(delay: (70 * e.key + 200).ms)
              .fadeIn(duration: 280.ms)
              .slideY(begin: 0.06, end: 0, duration: 280.ms),
        ),
      ),
    ];
  }
}

// ─── Segment toggle ────────────────────────────────────────────────────────────
class _SegmentToggle extends StatelessWidget {
  const _SegmentToggle({
    required this.showEvents,
    required this.onChanged,
  });

  final bool showEvents;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.darkEmber,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.borderHairline),
        ),
        child: Row(
          children: [
            Expanded(
              child: _SegmentButton(
                label: 'Desafíos',
                selected: !showEvents,
                onTap: () => onChanged(false),
                isLeft: true,
              ),
            ),
            Expanded(
              child: _SegmentButton(
                label: 'Eventos',
                selected: showEvents,
                onTap: () => onChanged(true),
                isLeft: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.isLeft,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: selected ? AppColors.gold : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: selected ? AppColors.obsidian : AppColors.midGray,
              fontWeight:
                  selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Challenge card ────────────────────────────────────────────────────────────
class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard({required this.challenge});

  final MockChallenge challenge;

  @override
  Widget build(BuildContext context) {
    final progress = challenge.targetValue > 0
        ? (challenge.progressValue / challenge.targetValue).clamp(0.0, 1.0)
        : 0.0;
    final isComplete = challenge.isCompleted;
    final isPremium = challenge.isPremium;

    return FynixCard(
      border: isComplete
          ? Border.all(color: AppColors.xpGreen.withAlpha(120), width: 1.5)
          : isPremium
              ? Border.all(color: AppColors.aiAccent.withAlpha(120), width: 1.5)
              : null,
      glowColor: isComplete
          ? AppColors.xpGreen
          : isPremium
              ? AppColors.aiAccent
              : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isComplete
                      ? AppColors.xpGreen.withAlpha(28)
                      : isPremium
                          ? AppColors.aiAccent.withAlpha(28)
                          : AppColors.flameCoral.withAlpha(28),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isComplete
                      ? Icons.check_circle_rounded
                      : isPremium
                          ? Icons.workspace_premium_rounded
                          : Icons.local_fire_department_rounded,
                  color: isComplete
                      ? AppColors.xpGreen
                      : isPremium
                          ? AppColors.aiAccent
                          : AppColors.flameCoral,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(challenge.title, style: AppTypography.h4),
                    const SizedBox(height: 2),
                    Text(
                      challenge.description,
                      style: AppTypography.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              // Rewards column
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: isComplete
                          ? const LinearGradient(
                              colors: [AppColors.xpGreen, Color(0xFF16A34A)],
                            )
                          : const LinearGradient(
                              colors: [AppColors.flameCoral, AppColors.gold],
                            ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '+${challenge.xpReward} XP',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.local_fire_department_rounded,
                        color: AppColors.flameCoral,
                        size: 11,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '+${challenge.emberReward}',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.flameCoral,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _GradientBar(progress: progress.toDouble(), isComplete: isComplete),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isComplete
                    ? '¡Completado!'
                    : '${challenge.progressValue % 1 == 0 ? challenge.progressValue.toInt() : challenge.progressValue.toStringAsFixed(1)} / ${challenge.targetValue % 1 == 0 ? challenge.targetValue.toInt() : challenge.targetValue.toStringAsFixed(1)} ${challenge.targetUnit}',
                style: AppTypography.labelSmall.copyWith(
                  color:
                      isComplete ? AppColors.xpGreen : AppColors.midGray,
                  fontWeight:
                      isComplete ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              Text(
                '${(progress * 100).toStringAsFixed(0)}%',
                style: AppTypography.labelSmall.copyWith(
                  color: isComplete ? AppColors.xpGreen : AppColors.gold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Race card ─────────────────────────────────────────────────────────────────
class _RaceCard extends StatelessWidget {
  const _RaceCard({required this.event});

  final MockEvent event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A0F00), Color(0xFF120A1A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.gold.withAlpha(80), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withAlpha(24),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top row: distance badge + countdown ──────────────────────
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.flameCoral,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  event.distance,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.gold.withAlpha(24),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.gold.withAlpha(60)),
                ),
                child: Text(
                  'CARRERA OFICIAL',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.gold,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    fontSize: 10,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'en ${event.endsInDays} días',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.flameCoral,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // ── Title ────────────────────────────────────────────────────
          Text(event.title, style: AppTypography.h3),
          const SizedBox(height: 4),
          Text(
            event.description,
            style: AppTypography.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.sm),

          // ── Race details row ─────────────────────────────────────────
          Row(
            children: [
              _RaceDetail(
                icon: Icons.calendar_today_rounded,
                label: event.raceDate,
              ),
              const SizedBox(width: AppSpacing.md),
              _RaceDetail(
                icon: Icons.location_on_rounded,
                label: event.location,
              ),
              const SizedBox(width: AppSpacing.md),
              _RaceDetail(
                icon: Icons.people_rounded,
                label: '${event.participants.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} inscritos',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // ── Bottom row: XP reward + fee + register button ─────────────
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.xpGreen.withAlpha(20),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.xpGreen.withAlpha(60)),
                ),
                child: Text(
                  event.reward,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.xpGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.honey, AppColors.gold],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Inscribirse',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.obsidian,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (event.registrationFee.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      Text(
                        event.registrationFee,
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.obsidian.withAlpha(180),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RaceDetail extends StatelessWidget {
  const _RaceDetail({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.midGray, size: 12),
        const SizedBox(width: 3),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.midGray,
          ),
        ),
      ],
    );
  }
}

// ─── Community event card ──────────────────────────────────────────────────────
class _CommunityEventCard extends StatelessWidget {
  const _CommunityEventCard({required this.event});

  final MockEvent event;

  @override
  Widget build(BuildContext context) {
    final progress = event.targetValue > 0
        ? (event.progressValue / event.targetValue).clamp(0.0, 1.0)
        : 0.0;
    final pct = (progress * 100).toStringAsFixed(0);

    return FynixCard(
      border: Border.all(color: AppColors.aiAccent.withAlpha(50)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header row ───────────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.aiAccent.withAlpha(28),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.volunteer_activism_rounded,
                  color: AppColors.aiAccent,
                  size: 18,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.title, style: AppTypography.h4),
                    const SizedBox(height: 2),
                    Text(
                      event.description,
                      style: AppTypography.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.timer_rounded,
                        color: AppColors.flameCoral,
                        size: 12,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${event.endsInDays}d',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.flameCoral,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.people_rounded,
                        color: AppColors.midGray,
                        size: 12,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${event.participants.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.midGray,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // ── Cause badge ──────────────────────────────────────────────
          if (event.cause.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                const Icon(
                  Icons.handshake_rounded,
                  color: AppColors.aiAccent,
                  size: 13,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${event.cause}  ·  ${event.causeImpact}',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.aiAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],

          // ── Progress bar ─────────────────────────────────────────────
          if (event.targetValue > 0) ...[
            const SizedBox(height: AppSpacing.sm),
            _GradientBar(
              progress: progress,
              isComplete: false,
              purple: true,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${event.progressValue.toStringAsFixed(0)} / ${event.targetValue.toStringAsFixed(0)} ${event.targetUnit}',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.midGray,
                  ),
                ),
                Text(
                  '$pct%',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.aiAccent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.aiAccent.withAlpha(20),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.aiAccent.withAlpha(60)),
            ),
            child: Text(
              event.reward,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.aiAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Gradient progress bar ─────────────────────────────────────────────────────
class _GradientBar extends StatelessWidget {
  const _GradientBar({
    required this.progress,
    required this.isComplete,
    this.gold = false,
    this.purple = false,
  });

  final double progress;
  final bool isComplete;
  final bool gold;
  final bool purple;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fillWidth = constraints.maxWidth * progress;
        const h = 7.0;
        return ClipRRect(
          borderRadius: BorderRadius.circular(h / 2),
          child: Stack(
            children: [
              Container(
                height: h,
                decoration: BoxDecoration(
                  color: AppColors.ember,
                  borderRadius: BorderRadius.circular(h / 2),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOut,
                width: fillWidth,
                height: h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isComplete
                        ? [AppColors.xpGreen, const Color(0xFF16A34A)]
                        : gold
                            ? [AppColors.honey, AppColors.gold]
                            : purple
                                ? [AppColors.aiAccent, const Color(0xFF9333EA)]
                                : [AppColors.flameCoral, AppColors.gold],
                  ),
                  borderRadius: BorderRadius.circular(h / 2),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

