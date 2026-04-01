import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:fynix/core/models/race_event.dart';

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
        .map((e) => RaceEvent.fromJson(e as Map<String, dynamic>))
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
      return e.copyWith(
        isRegistered: true,
        isCompleted: reg['completed'] as bool,
        registeredAt: DateTime.parse(reg['registered_at'] as String),
        completedAt: reg['completed_at'] != null
            ? DateTime.parse(reg['completed_at'] as String)
            : null,
        finishTimeSeconds: reg['finish_time_seconds'] as int?,
      );
    }).toList();
  }

  Future<RaceEvent?> fetchEvent(String eventId, {String? userId}) async {
    final data = await _client
        .from('race_events')
        .select()
        .eq('id', eventId)
        .single();

    var event = RaceEvent.fromJson(data as Map<String, dynamic>);

    if (userId != null) {
      final reg = await _client
          .from('user_event_registrations')
          .select()
          .eq('event_id', eventId)
          .eq('user_id', userId)
          .maybeSingle();

      if (reg != null) {
        event = event.copyWith(
          isRegistered: true,
          isCompleted: (reg as Map<String, dynamic>)['completed'] as bool,
        );
      }
    }

    return event;
  }

  Future<void> registerForEvent({
    required String userId,
    required String eventId,
  }) async {
    await _client.from('user_event_registrations').insert({
      'user_id': userId,
      'event_id': eventId,
    });
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
