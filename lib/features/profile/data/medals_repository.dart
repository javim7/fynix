import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'medals_repository.g.dart';

/// One earned digital medal row from `user_medals`.
class UserMedalRecord {
  const UserMedalRecord({
    required this.id,
    required this.eventId,
    required this.medalTitle,
    required this.medalAssetKey,
    required this.earnedAt,
  });

  final String id;
  final String eventId;
  final String medalTitle;
  final String medalAssetKey;
  final DateTime earnedAt;
}

@riverpod
MedalsRepository medalsRepository(Ref ref) => MedalsRepository();

class MedalsRepository {
  final _client = Supabase.instance.client;

  Future<List<UserMedalRecord>> fetchUserMedals(String userId) async {
    try {
      final data = await _client
          .from('user_medals')
          .select()
          .eq('user_id', userId)
          .order('earned_at', ascending: false);

      return (data as List).map((row) {
        final m = row as Map<String, dynamic>;
        return UserMedalRecord(
          id: m['id'] as String,
          eventId: m['event_id'] as String,
          medalTitle: m['medal_title'] as String,
          medalAssetKey: m['medal_asset_key'] as String,
          earnedAt: DateTime.parse(m['earned_at'] as String),
        );
      }).toList();
    } catch (_) {
      return [];
    }
  }
}
