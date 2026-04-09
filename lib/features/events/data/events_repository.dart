import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:fynix/core/models/race_event.dart';
import 'package:fynix/core/utils/supabase_row.dart';

part 'events_repository.g.dart';

@riverpod
EventsRepository eventsRepository(Ref ref) => EventsRepository();

class EventsRepository {
  final _client = Supabase.instance.client;

  Future<List<RaceEvent>> fetchUpcomingEvents({String? userId}) async {
    final now = DateTime.now().toIso8601String().split('T')[0];

    final data = await _client
        .from('race_events')
        .select()
        .gte('event_date', now)
        .order('event_date');

    final events = (data as List)
        .map((e) => raceEventFromSupabase(e as Map<String, dynamic>))
        .toList();

    if (userId == null) return events;

    // Fetch user registrations
    final regData = await _client
        .from('user_event_registrations')
        .select('event_id, registered_at, completed, completed_at, finish_time_seconds')
        .eq('user_id', userId);

    final regMap = {
      for (final r in (regData as List))
        (r as Map<String, dynamic>)['event_id'] as String: r,
    };

    return events.map((e) {
      final reg = regMap[e.id];
      if (reg == null) return e;
      final r = reg as Map<String, dynamic>;
      return e.copyWith(
        isRegistered: true,
        isCompleted: r['completed'] as bool? ?? false,
        registeredAt: DateTime.parse(r['registered_at'] as String),
        completedAt: r['completed_at'] != null
            ? DateTime.parse(r['completed_at'] as String)
            : null,
        finishTimeSeconds: r['finish_time_seconds'] as int?,
      );
    }).toList();
  }

  Future<RaceEvent?> fetchEvent(String eventId, {String? userId}) async {
    final data = await _client
        .from('race_events')
        .select()
        .eq('id', eventId)
        .single();

    var event = raceEventFromSupabase(data as Map<String, dynamic>);

    if (userId != null) {
      final reg = await _client
          .from('user_event_registrations')
          .select()
          .eq('event_id', eventId)
          .eq('user_id', userId)
          .maybeSingle();

      if (reg != null) {
        final m = reg as Map<String, dynamic>;
        event = raceEventFromSupabase(
          data as Map<String, dynamic>,
          registration: m,
        );
      }
    }

    return event;
  }

  Future<void> registerForEvent({
    required String userId,
    required String eventId,
  }) async {
    try {
      final res =
          await _client.rpc('join_event_challenge', params: {'p_event_id': eventId});
      if (res is Map && res['ok'] != true) {
        throw Exception(res['error'] ?? 'join_failed');
      }
    } catch (_) {
      await _client.from('user_event_registrations').insert({
        'user_id': userId,
        'event_id': eventId,
      });
    }
  }

  Future<void> unregisterFromEvent({
    required String userId,
    required String eventId,
  }) async {
    await _client
        .from('user_event_registrations')
        .delete()
        .eq('user_id', userId)
        .eq('event_id', eventId);
  }
}
