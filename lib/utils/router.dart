import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/screens/auth/login_screen.dart';
import 'package:myapp/screens/challenges/challenges_screen.dart';
import 'package:myapp/screens/history/history_screen.dart';
import 'package:myapp/screens/home/home_screen.dart';
import 'package:myapp/screens/leaderboard/leaderboard_screen.dart';
import 'package:myapp/screens/main/main_screen.dart';
import 'package:myapp/screens/profile/profile_screen.dart';
import 'package:myapp/screens/spin/spin_screen.dart';
import 'package:myapp/screens/statistics/statistics_screen.dart';
import 'package:myapp/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

class AppRouter {
  final BuildContext context;

  AppRouter(this.context);

  GoRouter get router {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final shellNavigatorKey = GlobalKey<NavigatorState>();

    return GoRouter(
      initialLocation: authProvider.user == null ? '/welcome' : '/',
      navigatorKey: rootNavigatorKey,
      routes: [
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) {
            return MainScreen(child: child);
          },
          routes: [
            GoRoute(
              path: '/',
              parentNavigatorKey: shellNavigatorKey,
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/spin',
              parentNavigatorKey: shellNavigatorKey,
              builder: (context, state) => SpinScreen(
                authProvider: authProvider,
              ),
            ),
            GoRoute(
              path: '/history',
              parentNavigatorKey: shellNavigatorKey,
              builder: (context, state) => HistoryScreen(
                authProvider: authProvider,
              ),
            ),
            GoRoute(
              path: '/leaderboard',
              parentNavigatorKey: shellNavigatorKey,
              builder: (context, state) => const LeaderboardScreen(),
            ),
            GoRoute(
              path: '/statistics',
              parentNavigatorKey: shellNavigatorKey,
              builder: (context, state) => StatisticsScreen(
                authProvider: authProvider,
              ),
            ),
            GoRoute(
              path: '/challenges',
              parentNavigatorKey: shellNavigatorKey,
              builder: (context, state) => const ChallengesScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/login',
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/welcome',
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: '/profile',
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => ProfileScreen(
            authProvider: authProvider,
          ),
        ),
      ],
      redirect: (context, state) {
        final isLoggedIn = authProvider.user != null;
        final isLoggingIn = state.matchedLocation == '/login';
        final isonWelcome = state.matchedLocation == '/welcome';

        if (!isLoggedIn && !isLoggingIn && !isonWelcome) {
          return '/welcome';
        }
        if (isLoggedIn && (isLoggingIn || isonWelcome)) {
          return '/';
        }

        return null;
      },
      refreshListenable: authProvider,
    );
  }
}
