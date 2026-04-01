import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fynix/core/models/workout.dart';

part 'challenge.freezed.dart';
part 'challenge.g.dart';

/// Challenge type matching the database enum.
enum ChallengeType {
  distance,
  duration,
  frequency,
  streak,
  sportSpecific,
  event,
}

/// A daily or special challenge — mirrors the `challenges` table.
@freezed
abstract class Challenge with _$Challenge {
  const factory Challenge({
    required String id,
    required ChallengeType challengeType,
    required String title,
    String? description,
    WorkoutSportType? sportType,
    required double targetValue,
    required String targetUnit,
    required int xpReward,
    @Default(true) bool isDaily,
    @Default(false) bool isPremium,
    String? icon,
    DateTime? startsAt,
    DateTime? expiresAt,
    required DateTime createdAt,

    // Progress fields (joined from user_challenge_progress)
    @Default(0) double progressValue,
    @Default(false) bool isCompleted,
    DateTime? completedAt,
  }) = _Challenge;

  factory Challenge.fromJson(Map<String, dynamic> json) =>
      _$ChallengeFromJson(json);
}
