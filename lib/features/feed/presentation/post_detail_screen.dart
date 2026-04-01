import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/widgets/fynix_avatar.dart';
import 'package:fynix/features/feed/domain/feed_notifier.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/feed/data/feed_repository.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  const PostDetailScreen({super.key, required this.postId});

  final String postId;

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  final _commentCtrl = TextEditingController();

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  Future<void> _submitComment() async {
    final content = _commentCtrl.text.trim();
    if (content.isEmpty) return;
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;

    await ref.read(feedRepositoryProvider).addComment(
          postId: widget.postId,
          authorId: user.id,
          content: content,
        );
    _commentCtrl.clear();
    ref.invalidate(postCommentsProvider(widget.postId));
  }

  @override
  Widget build(BuildContext context) {
    final postAsync = ref.watch(feedPostDetailProvider(widget.postId));
    final commentsAsync = ref.watch(postCommentsProvider(widget.postId));

    return Scaffold(
      appBar: AppBar(title: const Text('Publicación')),
      body: postAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.gold)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (post) {
          if (post == null) return const Center(child: Text('No encontrado'));
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    // Author
                    Row(
                      children: [
                        FynixAvatar(
                          displayName: post.author?.displayName,
                          size: 40,
                          level: post.author?.level,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          post.author?.displayName ?? 'Atleta',
                          style: AppTypography.bodyMedium,
                        ),
                      ],
                    ),
                    if (post.caption != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      Text(post.caption!, style: AppTypography.bodyLarge),
                    ],
                    const SizedBox(height: AppSpacing.lg),
                    Text('Comentarios', style: AppTypography.h4),
                    const SizedBox(height: AppSpacing.sm),
                    commentsAsync.when(
                      loading: () => const CircularProgressIndicator(
                          color: AppColors.gold),
                      error: (e, _) => Text('Error: $e'),
                      data: (comments) => comments.isEmpty
                          ? Text('Sin comentarios aún',
                              style: AppTypography.bodySmall)
                          : Column(
                              children: comments
                                  .map(
                                    (c) => Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: AppSpacing.sm),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FynixAvatar(
                                            displayName:
                                                c.author?.displayName,
                                            size: 32,
                                            showLevelBadge: false,
                                          ),
                                          const SizedBox(width: AppSpacing.sm),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  c.author?.displayName ??
                                                      '',
                                                  style: AppTypography
                                                      .labelLarge,
                                                ),
                                                Text(c.content,
                                                    style:
                                                        AppTypography.bodySmall),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                    ),
                  ],
                ),
              ),
              // Comment input
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentCtrl,
                          decoration: const InputDecoration(
                            hintText: 'Escribe un comentario...',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send_rounded,
                            color: AppColors.gold),
                        onPressed: _submitComment,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
