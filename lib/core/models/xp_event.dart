import 'package:freezed_annotation/freezed_annotation.dart';

part 'xp_event.freezed.dart';
part 'xp_event.g.dart';

/// Source of an XP award.
enum XpSource {
  workout,
  challenge,
  badge,
  event,
  streakBonus,
  manual,
}

/// Full audit record of every XP award — mirrors the `xp_events` table.
@freezed
abstract class XpEvent with _$XpEvent {
  const factory XpEvent({
    required String id,
    required String userId,
    required XpSource source,
    required int xpAmount,
    required String description,

    // Optional foreign keys (only one set per event)
    String? workoutId,
    String? challengeId,
    String? badgeId,
    String? eventId,

    Map<String, dynamic>? metadata,
    required DateTime createdAt,
  }) = _XpEvent;

  factory XpEvent.fromJson(Map<String, dynamic> json) =>
      _$XpEventFromJson(json);
}
