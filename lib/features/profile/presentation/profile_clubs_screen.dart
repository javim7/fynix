import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/widgets/fynix_card.dart';

// ─── Mock club data (shared within this screen) ───────────────────────────────
class _Club {
  const _Club({
    required this.name,
    required this.sport,
    required this.memberCount,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String name;
  final String sport;
  final int memberCount;
  final String description;
  final IconData icon;
  final Color color;
}

const _allClubs = [
  _Club(
    name: 'Runners LATAM',
    sport: 'Running',
    memberCount: 1248,
    description: 'La comunidad de corredores más grande de Latinoamérica.',
    icon: Icons.directions_run_rounded,
    color: AppColors.flameCoral,
  ),
  _Club(
    name: 'Ciclismo MX',
    sport: 'Ciclismo',
    memberCount: 632,
    description: 'Rodadas, rutas y retos para ciclistas de México.',
    icon: Icons.directions_bike_rounded,
    color: AppColors.gold,
  ),
  _Club(
    name: 'Triatletas Pro',
    sport: 'Triatlón',
    memberCount: 314,
    description: 'Entrenamiento serio para triatletas de todos los niveles.',
    icon: Icons.pool_rounded,
    color: AppColors.aiAccent,
  ),
  _Club(
    name: 'Fuerza & Vida',
    sport: 'Fuerza',
    memberCount: 891,
    description: 'Gym, powerlifting y entrenamiento funcional.',
    icon: Icons.fitness_center_rounded,
    color: AppColors.xpGreen,
  ),
  _Club(
    name: 'Trail & Montaña',
    sport: 'Trail',
    memberCount: 427,
    description: 'Senderismo, trail running y aventura en la montaña.',
    icon: Icons.terrain_rounded,
    color: AppColors.levelAccent,
  ),
  _Club(
    name: 'Yoga Flow',
    sport: 'Yoga',
    memberCount: 203,
    description: 'Mindfulness, movilidad y bienestar para atletas.',
    icon: Icons.self_improvement_rounded,
    color: AppColors.aiAccent,
  ),
  _Club(
    name: 'Sprint Club',
    sport: 'Atletismo',
    memberCount: 156,
    description: 'Velocidad, pista y competencias de atletismo.',
    icon: Icons.speed_rounded,
    color: AppColors.flameCoral,
  ),
];

class ProfileClubsScreen extends StatefulWidget {
  const ProfileClubsScreen({super.key});

  @override
  State<ProfileClubsScreen> createState() => _ProfileClubsScreenState();
}

class _ProfileClubsScreenState extends State<ProfileClubsScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  // Simulate joined clubs by index
  final Set<int> _joinedIndices = {0, 2};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<(int, _Club)> get _filtered {
    final indexed = _allClubs.asMap().entries.map((e) => (e.key, e.value)).toList();
    if (_query.isEmpty) return indexed;
    final q = _query.toLowerCase();
    return indexed
        .where((t) =>
            t.$2.name.toLowerCase().contains(q) ||
            t.$2.sport.toLowerCase().contains(q))
        .toList();
  }

  List<(int, _Club)> get _joined =>
      _filtered.where((t) => _joinedIndices.contains(t.$1)).toList();

  List<(int, _Club)> get _discover =>
      _filtered.where((t) => !_joinedIndices.contains(t.$1)).toList();

  @override
  Widget build(BuildContext context) {
    final joined = _joined;
    final discover = _discover;

    return Scaffold(
      appBar: AppBar(title: const Text('Mis clubs')),
      body: Column(
        children: [
          // ── Search bar ─────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.xs,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _query = v),
              style: AppTypography.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Buscar clubs...',
                hintStyle: AppTypography.bodyMedium.copyWith(
                  color: AppColors.midGray,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.midGray,
                  size: 20,
                ),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          color: AppColors.midGray,
                          size: 18,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.surface2,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: const BorderSide(color: AppColors.borderHairline),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: const BorderSide(color: AppColors.borderHairline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide:
                      const BorderSide(color: AppColors.gold, width: 1.5),
                ),
              ),
            ),
          ),

          // ── List ───────────────────────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.xl,
              ),
              children: [
                if (joined.isNotEmpty) ...[
                  _SectionLabel(label: 'Mis clubs (${joined.length})'),
                  const SizedBox(height: AppSpacing.sm),
                  ...joined.asMap().entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: _ClubCard(
                        club: e.value.$2,
                        joined: true,
                        onToggle: () =>
                            setState(() => _joinedIndices.remove(e.value.$1)),
                      ),
                    )
                        .animate(delay: (40 * e.key).ms)
                        .fadeIn(duration: 220.ms),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],

                if (discover.isNotEmpty) ...[
                  _SectionLabel(label: 'Descubrir clubs'),
                  const SizedBox(height: AppSpacing.sm),
                  ...discover.asMap().entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: _ClubCard(
                        club: e.value.$2,
                        joined: false,
                        onToggle: () =>
                            setState(() => _joinedIndices.add(e.value.$1)),
                      ),
                    )
                        .animate(delay: (40 * (joined.length + e.key)).ms)
                        .fadeIn(duration: 220.ms),
                  ),
                ],

                if (joined.isEmpty && discover.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: AppSpacing.xl),
                    child: Center(
                      child: Text(
                        'Sin resultados',
                        style: AppTypography.bodySmall,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTypography.labelMedium.copyWith(
        color: AppColors.midGray,
        letterSpacing: 0.8,
      ),
    );
  }
}

class _ClubCard extends StatelessWidget {
  const _ClubCard({
    required this.club,
    required this.joined,
    required this.onToggle,
  });

  final _Club club;
  final bool joined;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return FynixCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: club.color.withAlpha(28),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(club.icon, color: club.color, size: 22),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(club.name, style: AppTypography.bodyMedium),
                Text(
                  '${_fmt(club.memberCount)} miembros · ${club.sport}',
                  style: AppTypography.labelSmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: joined ? AppColors.darkEmber : AppColors.gold,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: joined ? AppColors.borderHairline : AppColors.gold,
                ),
              ),
              child: Text(
                joined ? 'Unido' : 'Unirse',
                style: AppTypography.labelSmall.copyWith(
                  color: joined ? AppColors.midGray : AppColors.obsidian,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(int n) =>
      n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}k' : '$n';
}
