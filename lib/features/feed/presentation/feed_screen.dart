import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fynix/app/router.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/models/feed_post.dart';
import 'package:fynix/core/utils/date_helpers.dart';
import 'package:fynix/core/utils/distance_formatter.dart';
import 'package:fynix/core/widgets/fynix_avatar.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
import 'package:fynix/core/widgets/sport_icon.dart';
import 'package:fynix/features/feed/data/feed_repository.dart';
import 'package:fynix/features/feed/domain/feed_notifier.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedAsync = ref.watch(feedPostsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.honey, AppColors.gold],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Center(
                child: Text(
                  'F',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.obsidian,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Text('Feed'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_search_rounded),
            onPressed: () => context.push(Routes.discover),
            tooltip: 'Descubrir atletas',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.obsidian,
        onPressed: () => context.push(Routes.createPost),
        child: const Icon(Icons.add_rounded),
      ),
      body: feedAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.gold),
        ),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (posts) => posts.isEmpty
            ? const _EmptyFeed()
            : RefreshIndicator(
                color: AppColors.gold,
                backgroundColor: AppColors.darkEmber,
                onRefresh: () => ref.refresh(feedPostsProvider.future),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.md,
                  ),
                  itemCount: posts.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, i) => _FeedCard(post: posts[i])
                      .animate(delay: (60 * i).ms)
                      .fadeIn(duration: 300.ms)
                      .slideY(begin: 0.06, end: 0, duration: 300.ms),
                ),
              ),
      ),
    );
  }
}

class _FeedCard extends ConsumerWidget {
  const _FeedCard({required this.post});

  final FeedPost post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final author = post.author;

    return FynixCard(
      padding: EdgeInsets.zero,
      onTap: () => context.push('/feed/post/${post.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author row
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                FynixAvatar(
                  imageUrl: null,
                  displayName: author?.displayName,
                  size: 40,
                  level: author?.level,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        author?.displayName ?? 'Atleta',
                        style: AppTypography.labelLarge,
                      ),
                      Text(
                        DateHelpers.formatRelative(post.createdAt),
                        style: AppTypography.labelSmall,
                      ),
                    ],
                  ),
                ),
                if (post.workout != null)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(28),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SportIcon(
                      sport: post.workout!.sportType,
                      size: 18,
                      color: AppColors.gold,
                    ),
                  ),
              ],
            ),
          ),

          // Caption
          if (post.caption != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(post.caption!, style: AppTypography.bodyMedium),
            ),

          // Workout stats
          if (post.workout != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface2,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(color: AppColors.borderHairline),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _WorkoutStat(
                      label: 'Distancia',
                      value: DistanceFormatter.formatKm(
                        post.workout!.distanceMeters,
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 32,
                    color: AppColors.borderHairline,
                  ),
                  Expanded(
                    child: _WorkoutStat(
                      label: 'XP ganado',
                      value: '+${post.workout!.xpEarned} XP',
                      valueColor: AppColors.gold,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Photo
          if (post.imageUrl != null) ...[
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(AppSpacing.radiusLg),
                bottomRight: Radius.circular(AppSpacing.radiusLg),
              ),
              child: CachedNetworkImage(
                imageUrl: post.imageUrl!,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
          ],

          // Actions bar
          if (post.imageUrl == null) const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.xs,
              AppSpacing.md,
              AppSpacing.md,
            ),
            child: Row(
              children: [
                _LikeButton(post: post),
                const SizedBox(width: AppSpacing.md),
                _CommentCount(count: post.commentCount),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutStat extends StatelessWidget {
  const _WorkoutStat({required this.label, required this.value, this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: AppTypography.labelLarge.copyWith(
            color: valueColor ?? AppColors.white,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(label, style: AppTypography.labelSmall),
      ],
    );
  }
}

class _LikeButton extends ConsumerStatefulWidget {
  const _LikeButton({required this.post});

  final FeedPost post;

  @override
  ConsumerState<_LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends ConsumerState<_LikeButton> {
  bool _animating = false;

  Future<void> _toggle() async {
    setState(() => _animating = true);
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (mounted) setState(() => _animating = false);

    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;
    final repo = ref.read(feedRepositoryProvider);
    if (widget.post.isLikedByMe) {
      await repo.unlikePost(widget.post.id, user.id);
    } else {
      await repo.likePost(widget.post.id, user.id);
    }
    ref.invalidate(feedPostsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final liked = widget.post.isLikedByMe;
    return GestureDetector(
      onTap: _toggle,
      child: Row(
        children: [
          AnimatedScale(
            scale: _animating ? 1.35 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.elasticOut,
            child: Icon(
              liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: liked ? AppColors.flameCoral : AppColors.midGray,
              size: 20,
            ),
          ),
          const SizedBox(width: 4),
          Text('${widget.post.likeCount}', style: AppTypography.labelMedium),
        ],
      ),
    );
  }
}

class _CommentCount extends StatelessWidget {
  const _CommentCount({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.chat_bubble_outline_rounded,
          color: AppColors.midGray,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text('$count', style: AppTypography.labelMedium),
      ],
    );
  }
}

class _EmptyFeed extends StatelessWidget {
  const _EmptyFeed();

  @override
  Widget build(BuildContext context) {
    return Center(
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
              Icons.people_rounded,
              size: 48,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const Text('Tu feed está vacío', style: AppTypography.h3),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Sigue a otros atletas para ver sus entrenos',
            style: AppTypography.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
