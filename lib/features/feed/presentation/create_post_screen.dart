import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/widgets/fynix_button.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/feed/data/feed_repository.dart';
import 'package:fynix/features/feed/domain/feed_notifier.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key, this.workoutId});

  final String? workoutId;

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final _captionCtrl = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _captionCtrl.dispose();
    super.dispose();
  }

  Future<void> _publish() async {
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;

    setState(() => _isSaving = true);
    try {
      await ref.read(feedRepositoryProvider).createPost(
            authorId: user.id,
            workoutId: widget.workoutId,
            caption: _captionCtrl.text.trim().isEmpty
                ? null
                : _captionCtrl.text.trim(),
          );
      ref.invalidate(feedPostsProvider);
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva publicación'),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _publish,
            child: Text(
              'Publicar',
              style: AppTypography.labelLarge.copyWith(color: AppColors.gold),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            TextField(
              controller: _captionCtrl,
              maxLines: 5,
              maxLength: 500,
              decoration: const InputDecoration(
                hintText: '¿Cómo fue el entreno? Comparte con la comunidad...',
                border: InputBorder.none,
              ),
              style: AppTypography.bodyLarge,
            ),
            const Spacer(),
            FynixButton(
              label: 'Publicar',
              onPressed: _publish,
              isLoading: _isSaving,
            ),
          ],
        ),
      ),
    );
  }
}
