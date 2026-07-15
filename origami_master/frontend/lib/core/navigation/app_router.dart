import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/explore/presentation/screens/explore_screen.dart';
import '../../features/gallery/presentation/pages/gallery_detail_page.dart';
import '../../features/gallery/presentation/pages/gallery_page.dart';
import '../../features/gallery/presentation/pages/create_gallery_page.dart';
import '../../features/gallery/presentation/pages/edit_gallery_page.dart';
import '../../features/gallery/presentation/pages/community_gallery_page.dart';
import '../../features/home/presentation/pages/edit_post_page.dart';
import '../../features/share/presentation/pages/generate_share_link_page.dart';
import '../../features/share/presentation/pages/shared_creation_page.dart';
import '../../features/share/presentation/pages/shared_links_page.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/origami/presentation/screens/completion_result_screen.dart';
import '../../features/origami/presentation/screens/fold_detail_screen.dart';
import '../../features/origami/presentation/screens/learning_step_screen.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/user_profile_page.dart';
import '../../features/comments/presentation/screens/comments_screen.dart';
import '../../features/social/presentation/screens/post_detail_screen.dart';
import '../../features/follow/presentation/pages/followers_page.dart';
import '../../features/follow/presentation/pages/following_page.dart';
import '../../features/home/presentation/pages/create_post_page.dart';
import '../../features/home/presentation/screens/search_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

abstract final class AppRouter {
  AppRouter._();

  static GoRouter _router = _createRouter();

  static GoRouter get router => _router;

  static void reset() {
    _router = _createRouter();
  }

  // Need to call this from main.dart to initialize with AuthBloc stream
  static void initialize(Stream<dynamic> authStream) {
    _router = _createRouter(authStream);
  }

  static GoRouter _createRouter([Stream<dynamic>? authStream]) => GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    refreshListenable: authStream != null ? GoRouterRefreshStream(authStream) : null,
    redirect: (context, state) {
      final authBloc = context.read<AuthBloc>();
      final authState = authBloc.state;
      
      if (state.uri.scheme == 'origamimaster' && state.uri.host == 'share') {
        final token = state.uri.pathSegments.isNotEmpty 
            ? state.uri.pathSegments.first 
            : state.uri.path.replaceAll('/', '');
        if (token.isNotEmpty) {
          return '/share/$token';
        }
      }

      final isPublicRoute = state.matchedLocation == '/splash' || 
                            state.matchedLocation == '/login' || 
                            state.matchedLocation == '/register' || 
                            state.matchedLocation.startsWith('/share/');
                            
      if (authState is Authenticated) {
        if (state.matchedLocation == '/login' || state.matchedLocation == '/register' || state.matchedLocation == '/splash') {
          return '/home';
        }
      } else if (authState is Unauthenticated || authState is AuthError) {
        if (!isPublicRoute) {
          return '/login';
        }
      }
      return null;
    },
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
      GoRoute(
        path: '/register',
        name: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
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
                name: RouteNames.myGallery,
                builder: (context, state) => const GalleryPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: RouteNames.profile,
                builder: (context, state) => const ProfilePage(),
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
        builder: (context, state) => GalleryDetailPage(
          creationId: state.pathParameters['creationId'] ?? '',
          source: state.uri.queryParameters['source'],
          showOwnerActions: state.uri.queryParameters['showOwnerActions'] != 'false',
        ),
      ),
      GoRoute(
        path: '/create-gallery',
        name: RouteNames.createGallery,
        builder: (context, state) => const CreateGalleryPage(),
      ),
      GoRoute(
        path: '/edit-gallery/:creationId',
        name: RouteNames.editGallery,
        builder: (context, state) => EditGalleryPage(
          creationId: state.pathParameters['creationId']!,
        ),
      ),
      GoRoute(
        path: '/community-gallery/:origamiId',
        name: RouteNames.communityGallery,
        builder: (context, state) => CommunityGalleryPage(
          origamiModelId: state.pathParameters['origamiId']!,
        ),
      ),
      GoRoute(
        path: '/edit-post/:postId',
        name: RouteNames.editPost,
        builder: (context, state) => EditPostPage(
          postId: state.pathParameters['postId'] ?? '',
        ),
      ),
      GoRoute(
        path: '/generate-share-link/:creationId',
        name: RouteNames.generateShareLink,
        builder: (context, state) => GenerateShareLinkPage(
          creationId: state.pathParameters['creationId'] ?? '',
        ),
      ),
      GoRoute(
        path: '/shared-links',
        name: RouteNames.sharedLinks,
        builder: (context, state) => SharedLinksPage(
          source: state.uri.queryParameters['source'],
          creationId: state.uri.queryParameters['creationId'],
        ),
      ),
      GoRoute(
        path: '/share/:token',
        name: RouteNames.sharedCreation,
        builder: (context, state) =>
            SharedCreationPage(token: state.pathParameters['token'] ?? ''),
      ),
      GoRoute(
        path: '/post-detail/:postId',
        name: RouteNames.postDetail,
        builder: (context, state) =>
            PostDetailScreen(postId: state.pathParameters['postId'] ?? ''),
      ),
      GoRoute(
        path: '/comments/:postId',
        name: RouteNames.comments,
        builder: (context, state) =>
            CommentsScreen(postId: state.pathParameters['postId'] ?? ''),
      ),
      GoRoute(
        path: '/user-profile/:userId',
        name: RouteNames.userProfile,
        builder: (context, state) =>
            UserProfilePage(userId: state.pathParameters['userId'] ?? ''),
      ),
      GoRoute(
        path: '/followers/:userId',
        name: RouteNames.followers,
        builder: (context, state) => FollowersPage(userId: state.pathParameters['userId'] ?? ''),
      ),
      GoRoute(
        path: '/following/:userId',
        name: RouteNames.following,
        builder: (context, state) => FollowingPage(userId: state.pathParameters['userId'] ?? ''),
      ),
      GoRoute(
        path: '/create-post',
        name: RouteNames.createPost,
        builder: (context, state) => const CreatePostPage(),
      ),
      GoRoute(
        path: '/search',
        name: RouteNames.search,
        builder: (context, state) => const SearchScreen(),
      ),
    ],
  );
}
