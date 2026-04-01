import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/models/user_profile.dart';
import 'package:fynix/core/widgets/fynix_avatar.dart';
import 'package:fynix/features/social/data/social_repository.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  final _searchCtrl = TextEditingController();
  List<UserProfile> _results = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _search(String query) async {
    if (query.length < 2) {
      setState(() => _results = []);
      return;
    }
    setState(() => _isSearching = true);
    try {
      final results =
          await ref.read(socialRepositoryProvider).searchUsers(query);
      setState(() => _results = results);
    } finally {
      setState(() => _isSearching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Descubrir atletas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: TextField(
              controller: _searchCtrl,
              onChanged: _search,
              decoration: const InputDecoration(
                hintText: 'Buscar por nombre o usuario',
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
          ),
          if (_isSearching)
            const LinearProgressIndicator(color: AppColors.gold),
          Expanded(
            child: ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, i) => _UserTile(user: _results[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.push('/u/${user.username}'),
      leading: FynixAvatar(
        displayName: user.displayName,
        size: 44,
        level: user.level,
      ),
      title: Text(user.displayName, style: AppTypography.bodyMedium),
      subtitle: Text('@${user.username}', style: AppTypography.bodySmall),
      trailing: Text(
        'Nv. ${user.level}',
        style: AppTypography.labelMedium.copyWith(color: AppColors.gold),
      ),
    );
  }
}
