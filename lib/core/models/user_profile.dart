import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// Subscription tier matching the database enum.
enum SubscriptionTier { free, premium }

/// Subscription status matching the database enum.
enum SubscriptionStatus { free, active, cancelled, expired, billingIssue }

/// User profile — mirrors the `users` table.
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String username,
    required String displayName,
    required String email,
    String? bio,
    @Default('default') String avatarId,
    String? city,
    @Default('GT') String country,

    // Gamification
    @Default(1) int level,
    @Default(0) int totalXp,
    @Default(500) int xpToNextLevel,
    @Default(0) int currentStreak,
    @Default(0) int longestStreak,
    DateTime? lastActivityDate,
    @Default(0) int streakFreezesRemaining,

    // Social
    @Default(0) int followingCount,
    @Default(0) int followerCount,

    // Totals
    @Default(0) int totalWorkouts,
    @Default(0) int totalDistanceMeters,
    @Default(0) int totalDurationSeconds,

    // Subscription
    @Default(SubscriptionStatus.free) SubscriptionStatus subscriptionStatus,
    @Default(SubscriptionTier.free) SubscriptionTier subscriptionTier,
    DateTime? subscriptionExpiresAt,
    String? revenuecatCustomerId,

    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
