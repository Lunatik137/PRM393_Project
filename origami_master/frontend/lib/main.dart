import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:app_links/app_links.dart';
import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/di/injection.dart';
import 'core/config/app_config.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Google Sign-In once at app startup (required by google_sign_in ^7.x)
  // On Android, the Web Client ID is also read from res/values/strings.xml
  await GoogleSignIn.instance.initialize(
    serverClientId: AppConfig.googleServerClientId,
  );

  configureDependencies();
  runApp(const OrigamiMasterApp());
}

class OrigamiMasterApp extends StatefulWidget {
  const OrigamiMasterApp({super.key});

  @override
  State<OrigamiMasterApp> createState() => _OrigamiMasterAppState();
}

class _OrigamiMasterAppState extends State<OrigamiMasterApp> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = getIt<AuthBloc>()..add(CheckSessionRequested());
    AppRouter.initialize(_authBloc.stream);
    _initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    _authBloc.close();
    super.dispose();
  }

  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();

    // Check initial link if app was in cold state (terminated)
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleDeepLink(initialUri);
      }
    } catch (e) {
      debugPrint('Failed to get initial deep link: $e');
    }

    // Handle link when app is in warm state (front or background)
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      _handleDeepLink(uri);
    }, onError: (err) {
      debugPrint('Failed to handle deep link stream: $err');
    });
  }

  void _handleDeepLink(Uri uri) {
    // Handle HTTPS app links: https://origamimaster.app/share/<token>
    if (uri.scheme == 'https' || uri.scheme == 'http') {
      if (uri.path.startsWith('/share/')) {
        AppRouter.router.push(uri.path);
      }
    }
    // Handle custom scheme: origamimaster://share/<token>
    else if (uri.scheme == 'origamimaster' && uri.host == 'share') {
      final token = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : uri.path;
      if (token.isNotEmpty) {
        AppRouter.router.push('/share/$token');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: _authBloc),
      ],
      child: MaterialApp.router(
        title: 'Origami Master',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
