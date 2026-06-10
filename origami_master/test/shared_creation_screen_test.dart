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

  Future<void> openSharedCreation(WidgetTester tester, String token) async {
    await tester.pumpWidget(createTestWidget());
    await pumpAndSettleIgnoringImages(tester);

    AppRouter.router.goNamed(
      RouteNames.sharedCreation,
      pathParameters: {'token': token},
    );
    await pumpAndSettleIgnoringImages(tester);
  }

  group('SharedCreationScreen Widget Tests', () {
    testWidgets('valid active token shows read-only creation details', (
      tester,
    ) async {
      await openSharedCreation(tester, 'active_token_abc');

      expect(find.text('Origami Master'), findsOneWidget);
      expect(find.textContaining('Read-only shared creation'), findsOneWidget);
      expect(find.text('My First Crane'), findsOneWidget);
      expect(find.text('Created by Hiroshi'), findsOneWidget);
      expect(find.text('Completed on 10/10/2023'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('Link Expired / Not Found'), findsNothing);
    });

    testWidgets('invalid token shows unavailable state only', (tester) async {
      await openSharedCreation(tester, 'missing_token');

      expect(find.text('Link Expired / Not Found'), findsOneWidget);
      expect(find.text('This shared link is unavailable.'), findsOneWidget);
      expect(find.text('My First Crane'), findsNothing);
      expect(find.text('Created by Hiroshi'), findsNothing);
    });

    testWidgets('disabled token shows unavailable state only', (tester) async {
      await openSharedCreation(tester, 'disabled_token_xyz');

      expect(find.text('Link Expired / Not Found'), findsOneWidget);
      expect(find.text('Summer Lotus'), findsNothing);
      expect(find.text('Created by Hiroshi'), findsNothing);
    });

    testWidgets('deleted linked creation shows unavailable state only', (
      tester,
    ) async {
      await CreationService.instance.deleteCreation('user_creation_001');

      await openSharedCreation(tester, 'active_token_abc');

      expect(find.text('Link Expired / Not Found'), findsOneWidget);
      expect(find.text('My First Crane'), findsNothing);
      expect(find.text('Created by Hiroshi'), findsNothing);
    });

    testWidgets('owner controls are never shown for valid shared creation', (
      tester,
    ) async {
      await openSharedCreation(tester, 'active_token_abc');

      expect(find.text('Edit Details'), findsNothing);
      expect(find.text('Delete Creation'), findsNothing);
      expect(find.text('Make Private'), findsNothing);
      expect(find.text('Make Public'), findsNothing);
      expect(find.text('Share Creation'), findsNothing);
      expect(find.text('Generate Share Link'), findsNothing);
    });
  });
}

Future<void> pumpAndSettleIgnoringImages(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
  while (tester.takeException() != null) {}
}
