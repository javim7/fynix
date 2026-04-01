import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:fynix/core/models/badge_model.dart';
import 'package:fynix/core/models/challenge.dart';
import 'package:fynix/core/models/xp_event.dart';

part 'gamification_repository.g.dart';

@riverpod
GamificationRepository gamificationRepository(Ref ref) =>
    GamificationRepository();

class GamificationRepository {
  final _client = Supabase.instance.client;

  /// Fetches today's challenges with user progress joined.
  Future<List<Challenge>> fetchDailyChallenges(String userId) async {
    final now = DateTime.now().toIso8601String();

    final data = await _client
        .from('challenges')
        .select()
        .eq('is_daily', true)
        .or('expires_at.is.null,expires_at.gt.$now')
        .limit(3);

    final challenges = (data as List)
        .map((e) => Challenge.fromJson(e as Map<String, dynamic>))
        .toList();

    // Fetch user progress for each challenge
    final challengeIds = challenges.map((c) => c.id).toList();
    if (challengeIds.isEmpty) return challenges;

    final progressData = await _client
        .from('user_challenge_progress')
        .select()
        .eq('user_id', userId)
        .inFilter('challenge_id', challengeIds);

    final progressMap = {
      for (final p in (progressData as List))
        (p as Map<String, dynamic>)['challenge_id'] as String: p,
    };

    return challenges.map((c) {
      final p = progressMap[c.id];
      if (p == null) return c;
      return c.copyWith(
        progressValue: (p['progress_value'] as num).toDouble(),
        isCompleted: p['is_completed'] as bool,
        completedAt: p['completed_at'] != null
            ? DateTime.parse(p['completed_at'] as String)
            : null,
      );
    }).toList();
  }

  Future<List<XpEvent>> fetchXpHistory(String userId, {int limit = 50}) async {
    final data = await _client
        .from('xp_events')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .limit(limit);

    return (data as List)
        .map((e) => XpEvent.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<BadgeModel>> fetchUserBadges(String userId) async {
    final allBadgesData = await _client
        .from('badges')
        .select()
        .order('sort_order');

    final unlockedData = await _client
        .from('user_badges')
        .select('badge_id, unlocked_at')
        .eq('user_id', userId);

    final unlockedMap = {
      for (final u in (unlockedData as List))
        (u as Map<String, dynamic>)['badge_id'] as String:
            DateTime.parse(u['unlocked_at'] as String),
    };

    return (allBadgesData as List).map((e) {
      final badge = BadgeModel.fromJson(e as Map<String, dynamic>);
      final unlockedAt = unlockedMap[badge.id];
      return badge.copyWith(
        isUnlocked: unlockedAt != null,
        unlockedAt: unlockedAt,
      );
    }).toList();
  }

  Future<List<Map<String, dynamic>>> fetchWeeklyLeaderboard(
      {int limit = 50}) async {
    final weekStart = _currentWeekStart();
    final data = await _client
        .from('leaderboard_weekly')
        .select('*, user:users(id, username, display_name, level, avatar_id)')
        .eq('week_start', weekStart)
        .order('total_xp', ascending: false)
        .limit(limit);
    return (data as List).cast<Map<String, dynamic>>();
  }

  String _currentWeekStart() {
    final now = DateTime.now();
    final weekday = now.weekday; // 1=Mon
    final monday = now.subtract(Duration(days: weekday - 1));
    return '${monday.year}-${monday.month.toString().padLeft(2, '0')}-${monday.day.toString().padLeft(2, '0')}';
  }
}
