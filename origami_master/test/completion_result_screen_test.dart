import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/core/navigation/app_router.dart';
import 'package:origami_master/core/services/auth_service.dart';
import 'package:origami_master/core/services/creation_service.dart';
import 'package:origami_master/core/theme/app_theme.dart';

void main() {
  setUp(() {
    AuthService.instance.setLoggedIn(true);
    AuthService.instance.setDelay(Duration.zero);
    AppRouter.reset();
  });

  Widget createTestWidget() {
    return MaterialApp.router(
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }

  group('CompletionResultScreen Widget Tests', () {
    testWidgets('starts as private by default', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      AppRouter.router.pushNamed(
        'completion-result',
        pathParameters: {'creationId': 'new_creation_origami_crane'},
      );
      await tester.pumpAndSettle();

      final switchFinder = find.byType(Switch);
      expect(switchFinder, findsOneWidget);

      final switchWidget = tester.widget<Switch>(switchFinder);
      expect(switchWidget.value, isFalse);
      expect(find.textContaining('This creation is private'), findsOneWidget);
    });

    testWidgets('public toggle changes state', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      AppRouter.router.pushNamed(
        'completion-result',
        pathParameters: {'creationId': 'new_creation_origami_crane'},
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      final switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, isTrue);
      expect(
        find.textContaining('visible in the Community Gallery'),
        findsOneWidget,
      );
    });

    testWidgets('Save Creation stores correct visibility', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      const creationId = 'new_creation_origami_crane_save';
      AppRouter.router.pushNamed(
        'completion-result',
        pathParameters: {'creationId': creationId},
      );
      await tester.pumpAndSettle();

      // Toggle to public
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      // Save
      await tester.tap(find.text('Save Creation'));
      await tester.pumpAndSettle();

      // Check if saved as public
      final savedCreation = await CreationService.instance.getCreationById(
        creationId,
      );
      expect(savedCreation, isNotNull);
      expect(savedCreation!.isPublic, isTrue);

      // Should navigate to Gallery
      expect(find.text('This is the Gallery Screen'), findsOneWidget);
    });

    testWidgets('Generate Share Link saves and navigates', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      const creationId = 'share_test_creation';
      AppRouter.router.pushNamed(
        'completion-result',
        pathParameters: {'creationId': creationId},
      );
      await tester.pumpAndSettle();

      // Tap Generate Share Link
      await tester.tap(find.text('Generate Share Link'));
      await tester.pumpAndSettle();

      // Check if saved (should be private by default)
      final savedCreation = await CreationService.instance.getCreationById(
        creationId,
      );
      expect(savedCreation, isNotNull);
      expect(savedCreation!.isPublic, isFalse);

      // Should navigate to Generate Share Link Screen
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text('Generate Share Link'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Continue Journey navigates to Home', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      AppRouter.router.pushNamed(
        'completion-result',
        pathParameters: {'creationId': 'new_creation_origami_crane'},
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue Journey'));
      await tester.pumpAndSettle();

      expect(find.text('Featured Fold'), findsOneWidget);
    });
  });
}
