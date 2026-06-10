import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final success = await AuthService.instance.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (success) {
      context.goNamed(RouteNames.home);
    } else {
      setState(() {
        _errorMessage =
            'Invalid email or password. Try demo@origami.com / password123';
      });
    }
  }

  Future<void> _handleGoogleLogin() async {
    setState(() {
      _isGoogleLoading = true;
      _errorMessage = null;
    });

    final success = await AuthService.instance.loginWithGoogle();

    if (!mounted) return;

    setState(() {
      _isGoogleLoading = false;
    });

    if (success) {
      context.goNamed(RouteNames.home);
    } else {
      setState(() {
        _errorMessage = 'Google login failed. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceWhite,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: AppRadius.large,
                          child: SvgPicture.asset(
                            'assets/icons/origami_logo.svg',
                            width: 96,
                            height: 96,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Center(
                        child: SizedBox(
                          width: 310,
                          child: Text(
                            'Welcome to Origami Master',
                            style: AppTextStyles.pageTitle.copyWith(
                              color: AppColors.primaryDark,
                              height: 1.15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Learn the art of paper folding, one\nstep at a time.',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textPrimary,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      if (_errorMessage != null) ...[
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppColors.danger.withValues(alpha: 0.1),
                            borderRadius: AppRadius.input,
                            border: Border.all(color: AppColors.danger),
                          ),
                          child: Text(
                            _errorMessage!,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.danger,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                      ],
                      _LoginTextField(
                        controller: _emailController,
                        hintText: 'Email address',
                        icon: Icons.mail_outline,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(
                            r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _LoginTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        icon: Icons.lock_outline,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _handleLogin(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      _ContinueButton(
                        onPressed: _handleLogin,
                        isLoading: _isLoading,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      const Row(
                        children: [
                          Expanded(child: Divider(color: AppColors.border)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                            ),
                            child: Text('OR', style: AppTextStyles.caption),
                          ),
                          Expanded(child: Divider(color: AppColors.border)),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      _GoogleButton(
                        isLoading: _isGoogleLoading,
                        onPressed: _isGoogleLoading ? null : _handleGoogleLogin,
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      Text(
                        'By continuing, you agree to our Terms of\nService and Privacy Policy.',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primaryDark,
                          height: 1.45,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;

  const _LoginTextField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: AppColors.secondary),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: AppRadius.large,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.large,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.large,
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.large,
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.large,
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.lg,
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const _ContinueButton({required this.onPressed, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.textOnPrimary,
                ),
              ),
            )
          : const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Continue'),
                SizedBox(width: AppSpacing.sm),
                Icon(Icons.arrow_forward, size: 20),
              ],
            ),
    );
  }
}

class _GoogleButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const _GoogleButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, AppSpacing.buttonHeight),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.primaryDark,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.large),
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/google_logo.svg',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: AppSpacing.md),
                const Text('Continue with Google'),
              ],
            ),
    );
  }
}
