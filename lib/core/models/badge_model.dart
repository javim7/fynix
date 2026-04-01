import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fynix/core/models/workout.dart';

part 'badge_model.freezed.dart';
part 'badge_model.g.dart';

/// A badge definition + optional unlock state — mirrors the `badges` table.
@freezed
abstract class BadgeModel with _$BadgeModel {
  const factory BadgeModel({
    required String id,
    required String title,
    required String description,
    required String iconAsset,
    required String conditionType,
    WorkoutSportType? conditionSport,
    required double conditionValue,
    @Default(0) int xpReward,
    @Default(false) bool isPremium,
    @Default(0) int sortOrder,
    required DateTime createdAt,

    // Unlock state (populated when loaded for a specific user)
    @Default(false) bool isUnlocked,
    DateTime? unlockedAt,
  }) = _BadgeModel;

  factory BadgeModel.fromJson(Map<String, dynamic> json) =>
      _$BadgeModelFromJson(json);
}
