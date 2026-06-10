import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/navigation/route_names.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final isLoggedIn = await AuthService.instance.checkSession();
    if (!mounted) return;

    if (isLoggedIn) {
      context.goNamed(RouteNames.home);
    } else {
      context.goNamed(RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.xxl,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 300,
                child: Text(
                  'O R I G A M I\nM A S T E R',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Literata',
                    fontSize: 40,
                    height: 1.32,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'THE ART OF PAPER',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 13,
                  height: 1.2,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
