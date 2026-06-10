import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/core/navigation/app_router.dart';
import 'package:origami_master/core/services/auth_service.dart';
import 'package:origami_master/core/theme/app_theme.dart';

void main() {
  setUp(() {
    AuthService.instance.setLoggedIn(false);
    AuthService.instance.setDelay(Duration.zero);
    AppRouter.reset();
  });

  Widget createTestWidget() {
    return MaterialApp.router(
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }

  group('LoginScreen Widget Tests', () {
    testWidgets('shows validation errors for empty fields', (tester) async {
      await tester.pumpWidget(createTestWidget());

      // Navigate to login (Splash will redirect if not logged in)
      await tester.pumpAndSettle();

      // Tap Continue button
      await tester.tap(find.text('Continue'));
      await tester.pump();

      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('shows error message for failed login', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextFormField).first,
        'wrong@email.com',
      );
      await tester.enterText(find.byType(TextFormField).last, 'wrongpassword');

      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Invalid email or password'), findsOneWidget);
    });

    testWidgets('navigates to Home on successful login', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextFormField).first,
        'demo@origami.com',
      );
      await tester.enterText(find.byType(TextFormField).last, 'password123');

      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      // Verify we are on Home (PlaceholderScreen with name 'Home')
      expect(find.text('This is the Home Screen'), findsOneWidget);
    });

    testWidgets('navigates to Home on Google login', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue with Google'));
      await tester.pumpAndSettle();

      // Verify we are on Home
      expect(find.text('This is the Home Screen'), findsOneWidget);
    });
  });
}
