import 'package:flutter/material.dart';
import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const OrigamiMasterApp());
}

class OrigamiMasterApp extends StatelessWidget {
  const OrigamiMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Origami Master',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }
}
