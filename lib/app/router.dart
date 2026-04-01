import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/features/auth/presentation/login_screen.dart';
import 'package:fynix/features/auth/presentation/onboarding_screen.dart';
import 'package:fynix/features/auth/presentation/register_screen.dart';
import 'package:fynix/features/avatar/presentation/avatar_screen.dart';
import 'package:fynix/features/events/presentation/event_detail_screen.dart';
import 'package:fynix/features/events/presentation/events_screen.dart';
import 'package:fynix/features/feed/presentation/create_post_screen.dart';
import 'package:fynix/features/feed/presentation/feed_screen.dart';
import 'package:fynix/features/feed/presentation/post_detail_screen.dart';
import 'package:fynix/features/gamification/presentation/badges_screen.dart';
import 'package:fynix/features/gamification/presentation/challenges_screen.dart';
import 'package:fynix/features/gamification/presentation/leaderboard_screen.dart';
import 'package:fynix/features/gamification/presentation/xp_history_screen.dart';
import 'package:fynix/features/home/presentation/home_screen.dart';
import 'package:fynix/features/integrations/presentation/coros_connect_screen.dart';
import 'package:fynix/features/integrations/presentation/garmin_connect_screen.dart';
import 'package:fynix/features/integrations/presentation/integrations_screen.dart';
import 'package:fynix/features/integrations/presentation/strava_connect_screen.dart';
import 'package:fynix/features/league/presentation/league_screen.dart';
import 'package:fynix/features/profile/presentation/profile_clubs_screen.dart';
import 'package:fynix/features/profile/presentation/profile_screen.dart';
import 'package:fynix/features/profile/presentation/user_profile_screen.dart';
import 'package:fynix/features/social/presentation/discover_screen.dart';
import 'package:fynix/features/social/presentation/followers_screen.dart';
import 'package:fynix/features/social/presentation/following_screen.dart';
import 'package:fynix/features/social/presentation/social_screen.dart';
import 'package:fynix/features/store/presentation/store_screen.dart';
import 'package:fynix/features/subscription/presentation/paywall_screen.dart';
import 'package:fynix/features/training/presentation/plan_detail_screen.dart';
import 'package:fynix/features/training/presentation/training_plans_screen.dart';
import 'package:fynix/features/training/presentation/workout_screen.dart';
import 'package:fynix/features/workouts/presentation/sync_screen.dart';
import 'package:fynix/features/workouts/presentation/workout_detail_screen.dart';
import 'package:fynix/features/workouts/presentation/workout_history_screen.dart';

part 'router.g.dart';

// ─── Route names ─────────────────────────────────────────────────────────────
abstract final class Routes {
  // Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String onboarding = '/onboarding';

  // Main tabs
  static const String home = '/home';
  static const String challenges = '/challenges';
  static const String league = '/league';
  static const String workouts = '/workouts';
  static const String profile = '/profile';

  // Gamification sub-routes
  static const String leaderboard = '/challenges/leaderboard';

  // Workouts sub-routes
  static const String workoutDetail = '/workouts/:workoutId';
  static const String xpHistory = '/workouts/xp-history';

  // Social sub-routes (full-screen push)
  static const String social = '/social';
  static const String discover = '/social/discover';
  static const String followers = '/social/followers';
  static const String following = '/social/following';

  // Feed sub-routes (full-screen push)
  static const String feed = '/feed';
  static const String postDetail = '/feed/post/:postId';
  static const String createPost = '/feed/create';

  // Profile sub-routes
  static const String badges = '/profile/badges';
  static const String avatar = '/profile/avatar';
  static const String integrations = '/profile/integrations';
  static const String profileClubs = '/profile/clubs';
  static const String stravaConnect = '/integrations/strava';
  static const String garminConnect = '/integrations/garmin';
  static const String corosConnect = '/integrations/coros';

  // Store
  static const String store = '/store';

  // Full-screen routes
  static const String userProfile = '/u/:username';
  static const String events = '/events';
  static const String eventDetail = '/events/:eventId';
  static const String trainingPlans = '/training';
  static const String planDetail = '/training/:planId';
  static const String trainingWorkout = '/training/:planId/workout/:workoutId';
  static const String sync = '/sync';
  static const String paywall = '/paywall';
}

// ─── Shell scaffold with bottom nav ──────────────────────────────────────────
class _AppShell extends ConsumerStatefulWidget {
  const _AppShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<_AppShell> {
  void _onTap(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: _BottomNav(
        currentIndex: widget.navigationShell.currentIndex,
        onTap: _onTap,
      ),
    );
  }
}

// ─── Bottom navigation bar ────────────────────────────────────────────────────
class _BottomNav extends StatelessWidget {
  const _BottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      decoration: const BoxDecoration(
        color: AppColors.surface0,
        border: Border(
          top: BorderSide(color: AppColors.ember, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _NavItem(
              icon: Icons.home_rounded,
              label: 'Home',
              selected: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            _NavItem(
              icon: Icons.local_fire_department_rounded,
              label: 'Retos',
              selected: currentIndex == 1,
              onTap: () => onTap(1),
            ),
            _CenterNavItem(
              selected: currentIndex == 2,
              onTap: () => onTap(2),
            ),
            _NavItem(
              icon: Icons.bar_chart_rounded,
              label: 'Progreso',
              selected: currentIndex == 3,
              onTap: () => onTap(3),
            ),
            _NavItem(
              icon: Icons.person_rounded,
              label: 'Perfil',
              selected: currentIndex == 4,
              onTap: () => onTap(4),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.gold : AppColors.midGray;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.gold.withAlpha(24)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: AppTypography.navLabel.copyWith(
                color: color,
                fontWeight:
                    selected ? FontWeight.w600 : FontWeight.w500,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

/// Elevated center League tab — gradient circle with trophy icon.
class _CenterNavItem extends StatelessWidget {
  const _CenterNavItem({required this.selected, required this.onTap});

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: const Offset(0, -10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: selected
                        ? [AppColors.honey, AppColors.gold]
                        : [AppColors.gold, const Color(0xFFB8860B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.goldGlow,
                      blurRadius: selected ? 20 : 12,
                      spreadRadius: selected ? 2 : 0,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  color: AppColors.obsidian,
                  size: 26,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -8),
              child: Text(
                'Liga',
                style: AppTypography.navLabel.copyWith(
                  color: selected ? AppColors.gold : AppColors.midGray,
                  fontWeight:
                      selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Router provider ─────────────────────────────────────────────────────────
@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: Routes.home,
    debugLogDiagnostics: true,
    routes: [
      // ─── Auth routes ────────────────────────────────────────────────────
      GoRoute(
        path: Routes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: Routes.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // ─── Paywall / Sync (no shell) ────────────────────────────────────
      GoRoute(
        path: Routes.paywall,
        name: 'paywall',
        builder: (context, state) => const PaywallScreen(),
      ),
      GoRoute(
        path: Routes.sync,
        name: 'sync',
        builder: (context, state) => const SyncScreen(),
      ),

      // ─── Store (full-screen push) ─────────────────────────────────────
      GoRoute(
        path: Routes.store,
        name: 'store',
        builder: (context, state) => const StoreScreen(),
      ),

      // ─── Main shell (bottom nav — 5 branches) ─────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            _AppShell(navigationShell: navigationShell),
        branches: [
          // ── Tab 0: Home ───────────────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home,
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          // ── Tab 1: Challenges ─────────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.challenges,
                name: 'challenges',
                builder: (context, state) => const ChallengesScreen(),
                routes: [
                  GoRoute(
                    path: 'leaderboard',
                    name: 'leaderboard',
                    builder: (context, state) => const LeaderboardScreen(),
                  ),
                ],
              ),
            ],
          ),

          // ── Tab 2: League (center) ────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.league,
                name: 'league',
                builder: (context, state) => const LeagueScreen(),
              ),
            ],
          ),

          // ── Tab 3: Progress (Workouts) ────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.workouts,
                name: 'workouts',
                builder: (context, state) => const WorkoutHistoryScreen(),
                routes: [
                  GoRoute(
                    path: ':workoutId',
                    name: 'workoutDetail',
                    builder: (context, state) => WorkoutDetailScreen(
                      workoutId: state.pathParameters['workoutId']!,
                    ),
                  ),
                  GoRoute(
                    path: 'xp-history',
                    name: 'xpHistory',
                    builder: (context, state) => const XpHistoryScreen(),
                  ),
                ],
              ),
            ],
          ),

          // ── Tab 4: Profile ────────────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profile,
                name: 'profile',
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'badges',
                    name: 'badges',
                    builder: (context, state) => const BadgesScreen(),
                  ),
                  GoRoute(
                    path: 'avatar',
                    name: 'avatar',
                    builder: (context, state) => const AvatarScreen(),
                  ),
                  GoRoute(
                    path: 'clubs',
                    name: 'profileClubs',
                    builder: (context, state) => const ProfileClubsScreen(),
                  ),
                  GoRoute(
                    path: 'integrations',
                    name: 'integrations',
                    builder: (context, state) => const IntegrationsScreen(),
                    routes: [
                      GoRoute(
                        path: 'strava',
                        name: 'stravaConnect',
                        builder: (context, state) =>
                            const StravaConnectScreen(),
                      ),
                      GoRoute(
                        path: 'garmin',
                        name: 'garminConnect',
                        builder: (context, state) =>
                            const GarminConnectScreen(),
                      ),
                      GoRoute(
                        path: 'coros',
                        name: 'corosConnect',
                        builder: (context, state) => const CorosConnectScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // ─── Full-screen routes (no shell) ────────────────────────────────
      GoRoute(
        path: '/u/:username',
        name: 'userProfile',
        builder: (context, state) => UserProfileScreen(
          username: state.pathParameters['username']!,
        ),
      ),
      GoRoute(
        path: Routes.social,
        name: 'social',
        builder: (context, state) => const SocialScreen(),
        routes: [
          GoRoute(
            path: 'discover',
            name: 'discover',
            builder: (context, state) => const DiscoverScreen(),
          ),
          GoRoute(
            path: 'followers',
            name: 'followers',
            builder: (context, state) => const FollowersScreen(),
          ),
          GoRoute(
            path: 'following',
            name: 'following',
            builder: (context, state) => const FollowingScreen(),
          ),
        ],
      ),
      GoRoute(
        path: Routes.feed,
        name: 'feed',
        builder: (context, state) => const FeedScreen(),
        routes: [
          GoRoute(
            path: 'post/:postId',
            name: 'postDetail',
            builder: (context, state) => PostDetailScreen(
              postId: state.pathParameters['postId']!,
            ),
          ),
          GoRoute(
            path: 'create',
            name: 'createPost',
            builder: (context, state) => const CreatePostScreen(),
          ),
        ],
      ),
      GoRoute(
        path: Routes.events,
        name: 'events',
        builder: (context, state) => const EventsScreen(),
        routes: [
          GoRoute(
            path: ':eventId',
            name: 'eventDetail',
            builder: (context, state) => EventDetailScreen(
              eventId: state.pathParameters['eventId']!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: Routes.trainingPlans,
        name: 'trainingPlans',
        builder: (context, state) => const TrainingPlansScreen(),
        routes: [
          GoRoute(
            path: ':planId',
            name: 'planDetail',
            builder: (context, state) => PlanDetailScreen(
              planId: state.pathParameters['planId']!,
            ),
            routes: [
              GoRoute(
                path: 'workout/:workoutId',
                name: 'trainingWorkout',
                builder: (context, state) => TrainingWorkoutScreen(
                  planId: state.pathParameters['planId']!,
                  workoutId: state.pathParameters['workoutId']!,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
