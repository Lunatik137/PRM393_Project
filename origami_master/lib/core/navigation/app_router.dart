import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/explore/presentation/screens/explore_screen.dart';
import '../../features/gallery/presentation/screens/creation_detail_screen.dart';
import '../../features/gallery/presentation/screens/gallery_screen.dart';
import '../../features/gallery/presentation/screens/generate_share_link_screen.dart';
import '../../features/gallery/presentation/screens/shared_creation_screen.dart';
import '../../features/gallery/presentation/screens/shared_links_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/origami/presentation/screens/completion_result_screen.dart';
import '../../features/origami/presentation/screens/fold_detail_screen.dart';
import '../../features/origami/presentation/screens/learning_step_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import 'main_shell.dart';
import 'route_names.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'home',
);
final GlobalKey<NavigatorState> _exploreNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'explore');
final GlobalKey<NavigatorState> _galleryNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'gallery');
final GlobalKey<NavigatorState> _profileNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'profile');

abstract final class AppRouter {
  AppRouter._();

  static GoRouter _router = _createRouter();

  static GoRouter get router => _router;

  static void reset() {
    _router = _createRouter();
  }

  static GoRouter _createRouter() => GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/home',
                name: RouteNames.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _exploreNavigatorKey,
            routes: [
              GoRoute(
                path: '/explore',
                name: RouteNames.explore,
                builder: (context, state) => const ExploreScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _galleryNavigatorKey,
            routes: [
              GoRoute(
                path: '/gallery',
                name: RouteNames.gallery,
                builder: (context, state) => const GalleryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: RouteNames.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/fold-detail/:origamiId',
        name: RouteNames.foldDetail,
        builder: (context, state) => FoldDetailScreen(
          origamiId: state.pathParameters['origamiId'] ?? '',
        ),
      ),
      GoRoute(
        path: '/learning-step/:origamiId',
        name: RouteNames.learningStep,
        builder: (context, state) => LearningStepScreen(
          origamiId: state.pathParameters['origamiId'] ?? '',
        ),
      ),
      GoRoute(
        path: '/completion-result/:creationId',
        name: RouteNames.completionResult,
        builder: (context, state) => CompletionResultScreen(
          creationId: state.pathParameters['creationId'] ?? '',
        ),
      ),
      GoRoute(
        path: '/creation-detail/:creationId',
        name: RouteNames.creationDetail,
        builder: (context, state) => CreationDetailScreen(
          creationId: state.pathParameters['creationId'] ?? '',
          source: state.uri.queryParameters['source'],
        ),
      ),
      GoRoute(
        path: '/generate-share-link/:creationId',
        name: RouteNames.generateShareLink,
        builder: (context, state) => GenerateShareLinkScreen(
          creationId: state.pathParameters['creationId'] ?? '',
        ),
      ),
      GoRoute(
        path: '/shared-links',
        name: RouteNames.sharedLinks,
        builder: (context, state) => SharedLinksScreen(
          source: state.uri.queryParameters['source'],
          creationId: state.uri.queryParameters['creationId'],
        ),
      ),
      GoRoute(
        path: '/share/:token',
        name: RouteNames.sharedCreation,
        builder: (context, state) =>
            SharedCreationScreen(token: state.pathParameters['token'] ?? ''),
      ),
    ],
  );
}
