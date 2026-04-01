import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fynix/app/router.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/models/user_profile.dart';
import 'package:fynix/core/widgets/fynix_avatar.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
import 'package:fynix/features/social/domain/social_notifier.dart';

class FollowingScreen extends ConsumerStatefulWidget {
  const FollowingScreen({super.key});

  @override
  ConsumerState<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends ConsumerState<FollowingScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<UserProfile> _filter(List<UserProfile> users) {
    if (_query.isEmpty) return users;
    final q = _query.toLowerCase();
    return users
        .where(
          (u) =>
              u.displayName.toLowerCase().contains(q) ||
              u.username.toLowerCase().contains(q),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final followingAsync = ref.watch(followingProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Siguiendo')),
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
                hintText: 'Buscar atletas que sigues...',
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
            child: followingAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(color: AppColors.gold),
              ),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (users) {
                final filtered = _filter(users);
                if (users.isEmpty) {
                  return _EmptyState(
                    message: 'No sigues a nadie',
                    subtext:
                        'Descubre atletas y síguelos para verlos aquí',
                    showDiscover: true,
                  );
                }
                if (filtered.isEmpty) {
                  return const _EmptyState(
                    message: 'Sin resultados',
                    subtext: 'Intenta con otro nombre o usuario',
                    showDiscover: false,
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.sm,
                    AppSpacing.md,
                    AppSpacing.xl,
                  ),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, i) =>
                      _UserCard(user: filtered[i])
                          .animate(delay: (40 * i).ms)
                          .fadeIn(duration: 220.ms),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return FynixCard(
      onTap: () => context.push('/u/${user.username}'),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          FynixAvatar(displayName: user.displayName, size: 44, level: user.level),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.displayName, style: AppTypography.bodyMedium),
                Text('@${user.username}', style: AppTypography.labelSmall),
              ],
            ),
          ),
          Text(
            'Nv. ${user.level}',
            style: AppTypography.labelSmall.copyWith(color: AppColors.gold),
          ),
          const SizedBox(width: AppSpacing.xs),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.midGray,
            size: 18,
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.message,
    required this.subtext,
    required this.showDiscover,
  });

  final String message;
  final String subtext;
  final bool showDiscover;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_search_rounded,
                size: 40,
                color: AppColors.gold,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(message, style: AppTypography.h4),
            const SizedBox(height: AppSpacing.xs),
            Text(
              subtext,
              style: AppTypography.bodySmall,
              textAlign: TextAlign.center,
            ),
            if (showDiscover) ...[
              const SizedBox(height: AppSpacing.lg),
              GestureDetector(
                onTap: () => context.push(Routes.discover),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Text(
                    'Descubrir atletas',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.obsidian,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
