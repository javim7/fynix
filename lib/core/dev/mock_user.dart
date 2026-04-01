import 'package:fynix/core/models/user_profile.dart';

/// Dummy user used for frontend-only navigation testing.
/// Level 12 · Gold II · 6-day streak
/// totalXp = 18430 → XpCalculator gives Level 12 at ~85% progress.
final kDevUser = UserProfile(
  id: 'dev-user-001',
  username: 'javimombiela',
  displayName: 'Javi Mombiela',
  email: 'javi@fynix.app',
  bio: 'Runner & cyclist · Ciudad de Guatemala',
  city: 'Ciudad de Guatemala',
  country: 'GT',
  level: 12,
  totalXp: 18430,
  xpToNextLevel: 318,
  currentStreak: 6,
  longestStreak: 21,
  followingCount: 34,
  followerCount: 58,
  totalWorkouts: 47,
  totalDistanceMeters: 312000,
  totalDurationSeconds: 82800,
  createdAt: DateTime(2025, 1, 15),
  updatedAt: DateTime.now(),
);
