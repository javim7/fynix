import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/dev/mock_data.dart';
import 'package:fynix/core/widgets/fynix_card.dart';

// ─── Zone constants ───────────────────────────────────────────────────────────
const _promotionZoneEnd = 6;
const _demotionZoneStart = 25;
const _promotionColor = AppColors.xpGreen;
const _demotionColor = AppColors.error;
const _promotionBg = Color(0x1222C55E); // xpGreen at 7% alpha
const _demotionBg = Color(0x12EF4444); // error at 7% alpha

class LeagueScreen extends StatefulWidget {
  const LeagueScreen({super.key});

  @override
  State<LeagueScreen> createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.obsidian,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(child: _LeagueHeader(tab: _tab)),
        ],
        body: TabBarView(
          controller: _tab,
          children: const [
            _AthletesTab(),
            _ClubsTab(),
          ],
        ),
      ),
    );
  }
}

// ─── League header ────────────────────────────────────────────────────────────
class _LeagueHeader extends StatelessWidget {
  const _LeagueHeader({required this.tab});

  final TabController tab;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A1400), AppColors.obsidian],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.md),

            // ── League badge + name ───────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LeagueBadge(name: kMockLeagueName),
              ],
            ).animate().fadeIn(duration: 400.ms).scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1, 1),
                  duration: 400.ms,
                  curve: Curves.easeOut,
                ),
            const SizedBox(height: AppSpacing.sm),

            // ── Time remaining ────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.timer_rounded,
                  size: 14,
                  color: AppColors.midGray,
                ),
                const SizedBox(width: 4),
                Text(
                  'Termina en $kMockDaysRemaining días',
                  style: AppTypography.labelSmall,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // ── User position summary ─────────────────────────────────
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.darkEmber,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(color: AppColors.borderHairline),
              ),
              child: Row(
                children: [
                  // Rank badge
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.gold.withAlpha(20),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.gold.withAlpha(80), width: 1.5),
                    ),
                    child: Center(
                      child: Text(
                        '#$kMockLeagueRank',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.gold,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tu posición esta semana',
                          style: AppTypography.labelSmall,
                        ),
                        Text(
                          '$kMockWeeklyXp XP · $kMockLeagueRank de $kMockLeagueTotal',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Promotion gap
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _promotionBg,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: _promotionColor.withAlpha(60)),
                    ),
                    child: Text(
                      '↑ $kMockXpToPromotion XP',
                      style: AppTypography.labelSmall.copyWith(
                        color: _promotionColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 350.ms).slideY(
                  begin: 0.08,
                  end: 0,
                  duration: 350.ms,
                ),
            const SizedBox(height: AppSpacing.md),

            // ── Tab bar ───────────────────────────────────────────────
            TabBar(
              controller: tab,
              indicatorColor: AppColors.gold,
              indicatorWeight: 2,
              labelColor: AppColors.gold,
              unselectedLabelColor: AppColors.midGray,
              labelStyle: AppTypography.labelMedium
                  .copyWith(fontWeight: FontWeight.w600),
              unselectedLabelStyle: AppTypography.labelMedium,
              tabs: const [
                Tab(text: 'Atletas'),
                Tab(text: 'Clubs'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── League badge widget ──────────────────────────────────────────────────────
class _LeagueBadge extends StatelessWidget {
  const _LeagueBadge({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [Color(0xFFFFD700), Color(0xFFB8860B)],
              center: Alignment(-0.3, -0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withAlpha(100),
                blurRadius: 24,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(
            Icons.emoji_events_rounded,
            color: AppColors.obsidian,
            size: 36,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(name, style: AppTypography.h3),
        Text(
          'Liga · Temporada actual',
          style: AppTypography.labelSmall,
        ),
      ],
    );
  }
}

// ─── Athletes tab ─────────────────────────────────────────────────────────────
class _AthletesTab extends StatelessWidget {
  const _AthletesTab();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.xl,
      ),
      itemCount: kMockLeagueAthletes.length + 2, // +2 for zone headers
      itemBuilder: (context, i) {
        // Injection index: add promotion header at index 0, demotion at 25+2=26 (raw)
        // Adjusted indices after header injections:
        //   index 0 → promotion zone header
        //   index 1..6 → ranks 1..6
        //   index 7 → demotion zone header
        //   index 8..25 → ranks 7..24
        //   index 26 → demotion zone header
        //   but simpler: map raw list index to row

        // Build a flat list with injected headers
        final items = _buildItems();
        if (i >= items.length) return const SizedBox.shrink();
        final item = items[i];

        if (item is _ZoneHeader) {
          return _ZoneHeaderRow(header: item).animate(delay: (20 * i).ms).fadeIn(duration: 200.ms);
        }
        final user = item as MockLeagueUser;
        return _AthleteRow(user: user)
            .animate(delay: (30 * i).ms)
            .fadeIn(duration: 250.ms);
      },
    );
  }

  List<Object> _buildItems() {
    final result = <Object>[];
    result.add(const _ZoneHeader(
      label: '↑  ZONA DE PROMOCIÓN',
      color: _promotionColor,
      bg: _promotionBg,
    ));
    for (final u in kMockLeagueAthletes) {
      if (u.rank == _demotionZoneStart) {
        result.add(const _ZoneHeader(
          label: '↓  ZONA DE DESCENSO',
          color: _demotionColor,
          bg: _demotionBg,
        ));
      }
      result.add(u);
    }
    return result;
  }
}

class _ZoneHeader {
  const _ZoneHeader({
    required this.label,
    required this.color,
    required this.bg,
  });

  final String label;
  final Color color;
  final Color bg;
}

class _ZoneHeaderRow extends StatelessWidget {
  const _ZoneHeaderRow({required this.header});

  final _ZoneHeader header;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: 6),
      decoration: BoxDecoration(
        color: header.bg,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(color: header.color.withAlpha(50)),
      ),
      child: Text(
        header.label,
        style: AppTypography.labelSmall.copyWith(
          color: header.color,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _AthleteRow extends StatelessWidget {
  const _AthleteRow({required this.user});

  final MockLeagueUser user;

  Color get _zoneBorderColor {
    if (user.rank <= _promotionZoneEnd) return _promotionColor;
    if (user.rank >= _demotionZoneStart) return _demotionColor;
    return Colors.transparent;
  }

  Color get _zoneBg {
    if (user.rank <= _promotionZoneEnd) return _promotionBg;
    if (user.rank >= _demotionZoneStart) return _demotionBg;
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    final isMe = user.isCurrentUser;
    final inZone = user.rank <= _promotionZoneEnd ||
        user.rank >= _demotionZoneStart;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        decoration: BoxDecoration(
          color: isMe
              ? AppColors.gold.withAlpha(12)
              : (inZone ? _zoneBg : AppColors.darkEmber),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: isMe
                ? AppColors.gold.withAlpha(80)
                : (inZone ? _zoneBorderColor.withAlpha(60) : AppColors.borderHairline),
            width: isMe ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Zone stripe
            Container(
              width: 4,
              height: 52,
              decoration: BoxDecoration(
                color: inZone ? _zoneBorderColor : Colors.transparent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppSpacing.radiusMd),
                  bottomLeft: Radius.circular(AppSpacing.radiusMd),
                ),
              ),
            ),

            // Rank
            SizedBox(
              width: 36,
              child: Center(
                child: _rankWidget(user.rank),
              ),
            ),

            // Avatar initials
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isMe
                    ? AppColors.gold.withAlpha(40)
                    : AppColors.surface2,
                shape: BoxShape.circle,
                border: isMe
                    ? Border.all(color: AppColors.gold, width: 1.5)
                    : null,
              ),
              child: Center(
                child: Text(
                  user.name[0],
                  style: AppTypography.labelMedium.copyWith(
                    color: isMe ? AppColors.gold : AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),

            // Name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: AppTypography.bodyMedium.copyWith(
                      color:
                          isMe ? AppColors.gold : AppColors.white,
                      fontWeight:
                          isMe ? FontWeight.w700 : FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('Nv. ${user.level}',
                      style: AppTypography.labelSmall),
                ],
              ),
            ),

            // XP
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.md),
              child: Text(
                '${user.weeklyXp} XP',
                style: AppTypography.labelLarge.copyWith(
                  color: isMe ? AppColors.gold : AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rankWidget(int rank) {
    switch (rank) {
      case 1:
        return const Icon(Icons.emoji_events_rounded,
            color: Color(0xFFFFD700), size: 20);
      case 2:
        return const Icon(Icons.emoji_events_rounded,
            color: Color(0xFFC0C0C0), size: 20);
      case 3:
        return const Icon(Icons.emoji_events_rounded,
            color: Color(0xFFCD7F32), size: 20);
      default:
        return Text(
          '$rank',
          style: AppTypography.labelMedium.copyWith(
            color: AppColors.midGray,
          ),
          textAlign: TextAlign.center,
        );
    }
  }
}

// ─── Clubs zone constants ─────────────────────────────────────────────────────
const _clubDemotionStart = 4; // top 2 promotion, ranks 4-5 demotion

// ─── Clubs tab ────────────────────────────────────────────────────────────────
class _ClubsTab extends StatelessWidget {
  const _ClubsTab();

  List<Object> _buildItems() {
    final result = <Object>[];
    result.add(const _ZoneHeader(
      label: '↑  ZONA DE PROMOCIÓN',
      color: _promotionColor,
      bg: _promotionBg,
    ));
    for (final club in kMockLeagueClubs) {
      if (club.rank == _clubDemotionStart) {
        result.add(const _ZoneHeader(
          label: '↓  ZONA DE DESCENSO',
          color: _demotionColor,
          bg: _demotionBg,
        ));
      }
      result.add(club);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final items = _buildItems();
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.xl,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final item = items[i];
        if (item is _ZoneHeader) {
          return _ZoneHeaderRow(header: item)
              .animate(delay: (20 * i).ms)
              .fadeIn(duration: 200.ms);
        }
        final club = item as MockLeagueClub;
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: _ClubRow(club: club)
              .animate(delay: (30 * i).ms)
              .fadeIn(duration: 250.ms),
        );
      },
    );
  }
}

class _ClubRow extends StatelessWidget {
  const _ClubRow({required this.club});

  final MockLeagueClub club;

  bool get _inPromotion => club.rank <= _clubDemotionStart - 1 && club.rank <= 2;
  bool get _inDemotion => club.rank >= _clubDemotionStart;
  bool get _inZone => _inPromotion || _inDemotion;

  Color get _zoneColor =>
      _inPromotion ? _promotionColor : _demotionColor;

  Color get _zoneBg =>
      _inPromotion ? _promotionBg : _demotionBg;

  @override
  Widget build(BuildContext context) {
    final isMe = club.isCurrentUserClub;

    return Container(
      decoration: BoxDecoration(
        color: isMe
            ? AppColors.gold.withAlpha(12)
            : (_inZone ? _zoneBg : AppColors.darkEmber),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: isMe
              ? AppColors.gold.withAlpha(80)
              : (_inZone ? _zoneColor.withAlpha(60) : AppColors.borderHairline),
          width: isMe ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          // Zone stripe
          Container(
            width: 4,
            height: 56,
            decoration: BoxDecoration(
              color: _inZone ? _zoneColor : Colors.transparent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSpacing.radiusMd),
                bottomLeft: Radius.circular(AppSpacing.radiusMd),
              ),
            ),
          ),

          // Rank
          SizedBox(
            width: 32,
            child: Center(child: _clubRank(club.rank)),
          ),

          // Club icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.gold.withAlpha(20),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: const Icon(
              Icons.groups_rounded,
              color: AppColors.gold,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      club.name,
                      style: AppTypography.bodyMedium.copyWith(
                        color: isMe ? AppColors.gold : AppColors.white,
                        fontWeight:
                            isMe ? FontWeight.w700 : FontWeight.w400,
                      ),
                    ),
                    if (isMe) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withAlpha(30),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'TÚ',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.gold,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  '${club.members} miembros · ${club.sport}',
                  style: AppTypography.labelSmall,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: Text(
              '${_fmtXp(club.weeklyXp)} XP',
              style: AppTypography.labelLarge.copyWith(
                color: isMe ? AppColors.gold : AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _clubRank(int rank) {
    if (rank == 1) {
      return const Icon(Icons.emoji_events_rounded,
          color: Color(0xFFFFD700), size: 18);
    }
    return Text(
      '#$rank',
      style: AppTypography.labelMedium.copyWith(color: AppColors.midGray),
      textAlign: TextAlign.center,
    );
  }

  String _fmtXp(int xp) =>
      xp >= 1000 ? '${(xp / 1000).toStringAsFixed(1)}k' : '$xp';
}
