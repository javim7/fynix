import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/models/user_profile.dart';
import 'package:fynix/core/utils/distance_formatter.dart';
import 'package:fynix/core/widgets/fynix_avatar.dart';
import 'package:fynix/core/widgets/fynix_button.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
import 'package:fynix/core/widgets/streak_badge.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/social/data/social_repository.dart';
import 'package:fynix/features/social/domain/social_notifier.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userByUsernameProvider(username));

    return Scaffold(
      appBar: AppBar(title: Text('@$username')),
      body: userAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.gold)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (user) => user == null
            ? Center(
                child: Text('Usuario no encontrado', style: AppTypography.bodySmall))
            : _UserProfileBody(user: user),
      ),
    );
  }
}

class _UserProfileBody extends ConsumerStatefulWidget {
  const _UserProfileBody({required this.user});

  final UserProfile user;

  @override
  ConsumerState<_UserProfileBody> createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends ConsumerState<_UserProfileBody> {
  bool? _isFollowing;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkFollowing();
  }

  Future<void> _checkFollowing() async {
    final me = ref.read(authNotifierProvider).value;
    if (me == null) return;
    final result = await ref
        .read(socialRepositoryProvider)
        .isFollowing(me.id, widget.user.id);
    if (mounted) setState(() => _isFollowing = result);
  }

  Future<void> _toggleFollow() async {
    final me = ref.read(authNotifierProvider).value;
    if (me == null) return;
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(socialRepositoryProvider);
      if (_isFollowing == true) {
        await repo.unfollow(me.id, widget.user.id);
        setState(() => _isFollowing = false);
      } else {
        await repo.follow(me.id, widget.user.id);
        setState(() => _isFollowing = true);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final me = ref.watch(authNotifierProvider).value;
    final isMe = me?.id == user.id;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Row(
          children: [
            FynixAvatar(
              displayName: user.displayName,
              size: 64,
              level: user.level,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.displayName, style: AppTypography.h2),
                  if (user.bio != null)
                    Text(user.bio!, style: AppTypography.bodySmall),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        StreakBadge(streakDays: user.currentStreak),
        const SizedBox(height: AppSpacing.md),
        if (!isMe)
          FynixButton(
            label: _isFollowing == true ? 'Siguiendo' : 'Seguir',
            onPressed: _toggleFollow,
            isLoading: _isLoading,
            variant: _isFollowing == true
                ? FynixButtonVariant.secondary
                : FynixButtonVariant.primary,
          ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Stat('Nv. ${user.level}', 'Nivel'),
            _Stat('${user.totalXp} XP', 'Total'),
            _Stat(DistanceFormatter.formatKm(user.totalDistanceMeters.toDouble()), 'Distancia'),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Stat('${user.followerCount}', 'Seguidores'),
            _Stat('${user.followingCount}', 'Siguiendo'),
            _Stat('${user.totalWorkouts}', 'Entrenos'),
          ],
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.value, this.label);

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return FynixCard(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: Column(
        children: [
          Text(value, style: AppTypography.statLarge),
          Text(label, style: AppTypography.labelSmall),
        ],
      ),
    );
  }
}
