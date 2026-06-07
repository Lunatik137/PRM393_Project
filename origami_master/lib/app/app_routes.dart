import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/fold_detail/screens/fold_detail_screen.dart';
import '../features/learning/screens/learning_step_screen.dart';
import '../features/completion/screens/completion_result_screen.dart';
import '../features/sharing/screens/creation_detail_screen.dart';
import '../features/sharing/screens/generate_share_link_screen.dart';
import '../features/sharing/screens/shared_links_screen.dart';
import '../features/sharing/screens/shared_creation_screen.dart';
import '../features/achievement/screens/achievement_list_screen.dart';
import '../features/auth/screens/splash_screen.dart';
import 'app_shell.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String explore = '/explore';
  static const String foldDetail = '/fold-detail';
  static const String learningStep = '/learning-step';
  static const String completionResult = '/completion-result';
  static const String gallery = '/gallery';
  static const String creationDetail = '/creation-detail';
  static const String generateShareLink = '/generate-share-link';
  static const String sharedLinks = '/shared-links';
  static const String sharedCreation = '/shared-creation';
  static const String achievements = '/achievements';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    home: (context) => const AppShell(initialIndex: 0),
    explore: (context) => const AppShell(initialIndex: 1),
    gallery: (context) => const AppShell(initialIndex: 2),
    profile: (context) => const AppShell(initialIndex: 3),
    foldDetail: (context) => const FoldDetailScreen(),
    learningStep: (context) => const LearningStepScreen(),
    completionResult: (context) => const CompletionResultScreen(),
    creationDetail: (context) => const CreationDetailScreen(),
    generateShareLink: (context) => const GenerateShareLinkScreen(),
    sharedLinks: (context) => const SharedLinksScreen(),
    sharedCreation: (context) => const SharedCreationScreen(),
    achievements: (context) => const AchievementListScreen(),
  };
}
