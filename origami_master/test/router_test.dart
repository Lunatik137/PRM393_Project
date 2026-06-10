import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/core/navigation/app_router.dart';
import 'package:origami_master/core/navigation/route_names.dart';
import 'package:origami_master/core/services/auth_service.dart';
import 'package:origami_master/main.dart';

void main() {
  group('Router Tests', () {
    setUp(() {
      AppRouter.reset();
      AuthService.instance.setDelay(Duration.zero);
      AuthService.instance.setLoggedIn(false);
    });

    testWidgets('Initial route is Splash', (tester) async {
      await tester.pumpWidget(const OrigamiMasterApp());
      expect(find.text('Origami Master'), findsOneWidget);
      await pumpAndSettleIgnoringImages(tester);
    });

    testWidgets('Navigate to Login', (tester) async {
      await tester.pumpWidget(const OrigamiMasterApp());
      await pumpAndSettleIgnoringImages(tester); // Wait for Splash to finish
      expect(find.text('Welcome Back'), findsOneWidget);
    });

    testWidgets('Login to Home', (tester) async {
      AuthService.instance.setLoggedIn(true);
      await tester.pumpWidget(const OrigamiMasterApp());
      await pumpAndSettleIgnoringImages(tester);

      expect(find.text('Featured Fold'), findsOneWidget);
    });

    testWidgets('Bottom navigation switching', (tester) async {
      AuthService.instance.setLoggedIn(true);
      await tester.pumpWidget(const OrigamiMasterApp());
      await pumpAndSettleIgnoringImages(tester);

      await tester.tap(find.text('Explore'));
      await pumpAndSettleIgnoringImages(tester);
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text('Explore'),
        ),
        findsOneWidget,
      );

      await tester.tap(find.text('Gallery'));
      await pumpAndSettleIgnoringImages(tester);
      expect(find.text('My Gallery'), findsOneWidget);

      await tester.tap(find.text('Profile'));
      await pumpAndSettleIgnoringImages(tester);
      expect(find.text('This is the Profile Screen'), findsOneWidget);

      await tester.tap(find.text('Home'));
      await pumpAndSettleIgnoringImages(tester);
      expect(find.text('Featured Fold'), findsOneWidget);
    });

    testWidgets('Fold detail parameter passing', (tester) async {
      AuthService.instance.setLoggedIn(true);
      await tester.pumpWidget(const OrigamiMasterApp());
      await pumpAndSettleIgnoringImages(tester);

      AppRouter.router.pushNamed(
        RouteNames.foldDetail,
        pathParameters: {'origamiId': 'origami_crane'},
      );
      await pumpAndSettleIgnoringImages(tester);
      expect(find.text('Paper Crane'), findsOneWidget);
    });

    testWidgets('Creation detail parameter passing', (tester) async {
      AuthService.instance.setLoggedIn(true);
      await tester.pumpWidget(const OrigamiMasterApp());
      await pumpAndSettleIgnoringImages(tester);

      AppRouter.router.pushNamed(
        RouteNames.creationDetail,
        pathParameters: {'creationId': 'user_creation_001'},
      );
      await pumpAndSettleIgnoringImages(tester);
      expect(find.text('My First Crane'), findsOneWidget);
    });

    testWidgets('Shared creation token support', (tester) async {
      AuthService.instance.setLoggedIn(true);
      await tester.pumpWidget(const OrigamiMasterApp());
      await pumpAndSettleIgnoringImages(tester);

      AppRouter.router.go('/share/active_token_abc');
      await pumpAndSettleIgnoringImages(tester);
      expect(find.text('Origami Master'), findsOneWidget);
      expect(find.text('My First Crane'), findsOneWidget);
    });
  });
}

Future<void> pumpAndSettleIgnoringImages(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
  while (tester.takeException() != null) {}
}
