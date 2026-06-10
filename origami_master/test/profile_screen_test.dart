import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/core/navigation/app_router.dart';
import 'package:origami_master/core/navigation/route_names.dart';
import 'package:origami_master/core/services/auth_service.dart';
import 'package:origami_master/core/services/creation_service.dart';
import 'package:origami_master/core/services/share_link_service.dart';
import 'package:origami_master/core/theme/app_theme.dart';

void main() {
  setUp(() {
    AuthService.instance.setLoggedIn(true);
    AuthService.instance.setDelay(Duration.zero);
    CreationService.instance.reset();
    ShareLinkService.instance.reset();
    AppRouter.reset();
  });

  Widget createTestWidget() {
    return MaterialApp.router(
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }

  Future<void> openProfile(WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await pumpAndSettleIgnoringImages(tester);

    AppRouter.router.goNamed(RouteNames.profile);
    await pumpAndSettleIgnoringImages(tester);
  }

  group('ProfileScreen Widget Tests', () {
    testWidgets('shows calculated counts from current user creations', (
      tester,
    ) async {
      await openProfile(tester);

      expect(find.text('Hiroshi Sato'), findsOneWidget);
      expect(find.text('Completed Folds'), findsOneWidget);
      expect(find.text('Public Creations'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('does not show prohibited profile content', (tester) async {
      await openProfile(tester);

      expect(find.text('hiroshi.sato@origami.app'), findsNothing);
      expect(find.textContaining('Private Creations'), findsNothing);
      expect(find.textContaining('Achievement'), findsNothing);
      expect(find.textContaining('XP'), findsNothing);
      expect(find.textContaining('Badge'), findsNothing);
      expect(find.textContaining('Rank'), findsNothing);
      expect(find.textContaining('Streak'), findsNothing);
    });

    testWidgets('My Shared Links opens Shared Links Screen', (tester) async {
      await openProfile(tester);

      await tester.tap(find.text('My Shared Links'));
      await pumpAndSettleIgnoringImages(tester);

      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text('Shared Links'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Settings opens settings dialog', (tester) async {
      await openProfile(tester);

      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsWidgets);
      expect(find.text('Settings are not available yet.'), findsOneWidget);
    });

    testWidgets('Logout confirmation clears session and opens Login', (
      tester,
    ) async {
      await openProfile(tester);

      await tester.tap(find.widgetWithText(ListTile, 'Logout'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));

      expect(find.text('Logout?'), findsOneWidget);

      await tester.tap(find.widgetWithText(TextButton, 'Logout'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump();

      expect(find.text('Welcome to Origami Master'), findsOneWidget);
      expect(AuthService.instance.isLoggedIn, isFalse);
    });

    testWidgets('bottom navigation opens Home Explore and Gallery', (
      tester,
    ) async {
      await openProfile(tester);

      await tester.tap(find.text('Home'));
      await pumpAndSettleIgnoringImages(tester);
      expect(find.text('Featured Fold'), findsOneWidget);

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
    });
  });
}

Future<void> pumpAndSettleIgnoringImages(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
  while (tester.takeException() != null) {}
}
