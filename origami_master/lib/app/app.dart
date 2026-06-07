import 'package:flutter/material.dart';
import 'app_routes.dart';
import 'app_theme.dart';

class OrigamiMasterApp extends StatelessWidget {
  const OrigamiMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Origami Master',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
