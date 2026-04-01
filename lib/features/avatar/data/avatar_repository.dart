import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'avatar_repository.g.dart';

@riverpod
AvatarRepository avatarRepository(Ref ref) => AvatarRepository();

class AvatarRepository {
  final _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchAllSkins() async {
    final data = await _client
        .from('avatar_skins')
        .select()
        .order('sort_order');
    return (data as List).cast<Map<String, dynamic>>();
  }

  Future<void> equipSkin({
    required String userId,
    required String skinId,
  }) async {
    await _client
        .from('users')
        .update({'avatar_id': skinId})
        .eq('id', userId);
  }
}
