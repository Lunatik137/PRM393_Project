import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/core/navigation/app_router.dart';
import 'package:origami_master/core/services/auth_service.dart';
import 'package:origami_master/main.dart';

void main() {
  group('SplashScreen Tests', () {
    setUp(() {
      AppRouter.reset();
      AuthService.instance.setDelay(Duration.zero);
    });

    testWidgets('Valid session opens Home Screen', (tester) async {
      // Set session to valid
      AuthService.instance.setLoggedIn(true);

      await tester.pumpWidget(const OrigamiMasterApp());

      // Splash screen should be visible initially
      expect(find.text('Origami Master'), findsOneWidget);

      // Wait for the initialization
      await tester.pumpAndSettle();

      // Should navigate to Home
      expect(find.text('This is the Home Screen'), findsOneWidget);
    });

    testWidgets('Invalid session opens Login Screen', (tester) async {
      // Set session to invalid
      AuthService.instance.setLoggedIn(false);

      await tester.pumpWidget(const OrigamiMasterApp());

      // Splash screen should be visible initially
      expect(find.text('Origami Master'), findsOneWidget);

      // Wait for the initialization
      await tester.pumpAndSettle();

      // Should navigate to Login
      expect(find.text('This is the Login Screen'), findsOneWidget);
    });
  });
}
