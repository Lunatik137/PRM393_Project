import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/core/navigation/app_router.dart';
import 'package:origami_master/core/navigation/route_names.dart';
import 'package:origami_master/core/services/auth_service.dart';
import 'package:origami_master/core/services/creation_service.dart';
import 'package:origami_master/core/theme/app_theme.dart';

void main() {
  setUp(() {
    AuthService.instance.setLoggedIn(true);
    AuthService.instance.setDelay(Duration.zero);
    CreationService.instance.reset();
    AppRouter.reset();
  });

  Widget createTestWidget() {
    return MaterialApp.router(
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }

  Future<void> pumpAndSettleIgnoringImages(WidgetTester tester) async {
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    // Clear any image loading exceptions that occurred during pumping
    while (tester.takeException() != null) {}
  }

  group('CreationDetailScreen Widget Tests', () {
    testWidgets('Owner View shows management actions', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      const creationId = 'user_creation_001';

      await tester.pumpWidget(createTestWidget());
      await pumpAndSettleIgnoringImages(tester);

      AppRouter.router.pushNamed(
        'creation-detail',
        pathParameters: {'creationId': creationId},
      );
      await pumpAndSettleIgnoringImages(tester);

      expect(find.text('Edit Details'), findsOneWidget);
      expect(find.text('Make Private'), findsOneWidget);
      expect(find.text('Share Creation'), findsOneWidget);
      expect(find.text('Delete Creation'), findsOneWidget);
    });

    testWidgets('Community View (non-owner) hides management actions', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      const creationId = 'creation_001';

      await tester.pumpWidget(createTestWidget());
      await pumpAndSettleIgnoringImages(tester);

      AppRouter.router.pushNamed(
        'creation-detail',
        pathParameters: {'creationId': creationId},
      );
      await pumpAndSettleIgnoringImages(tester);

      expect(find.text('Edit Details'), findsNothing);
      expect(find.text('Share Creation'), findsNothing);
      expect(find.text('Delete Creation'), findsNothing);
    });

    testWidgets('Toggling visibility updates the UI', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      const creationId = 'user_creation_001';

      await tester.pumpWidget(createTestWidget());
      await pumpAndSettleIgnoringImages(tester);

      AppRouter.router.pushNamed(
        'creation-detail',
        pathParameters: {'creationId': creationId},
      );
      await pumpAndSettleIgnoringImages(tester);

      expect(find.text('Make Private'), findsOneWidget);

      await tester.tap(find.text('Make Private'));
      await pumpAndSettleIgnoringImages(tester);

      expect(find.text('Make Public'), findsOneWidget);

      final creation = await CreationService.instance.getCreationById(
        creationId,
      );
      expect(creation!.isPublic, isFalse);
    });

    testWidgets('Delete shows confirmation dialog and removes creation', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      const creationId = 'user_creation_001';

      await tester.pumpWidget(createTestWidget());
      await pumpAndSettleIgnoringImages(tester);

      AppRouter.router.pushNamed(
        'creation-detail',
        pathParameters: {'creationId': creationId},
      );
      await pumpAndSettleIgnoringImages(tester);

      await tester.ensureVisible(find.text('Delete Creation'));
      await tester.tap(find.text('Delete Creation'));
      await pumpAndSettleIgnoringImages(tester);

      expect(
        find.textContaining('Are you sure you want to delete this creation?'),
        findsOneWidget,
      );

      await tester.tap(find.text('Delete'));
      await pumpAndSettleIgnoringImages(tester);

      expect(find.text('Featured Fold'), findsOneWidget);

      final creation = await CreationService.instance.getCreationById(
        creationId,
      );
      expect(creation, isNull);
    });

    testWidgets('Share Creation navigates to Generate Share Link', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      const creationId = 'user_creation_001';

      await tester.pumpWidget(createTestWidget());
      await pumpAndSettleIgnoringImages(tester);

      AppRouter.router.pushNamed(
        'creation-detail',
        pathParameters: {'creationId': creationId},
      );
      await pumpAndSettleIgnoringImages(tester);

      await tester.ensureVisible(find.text('Share Creation'));
      await tester.tap(find.text('Share Creation'));
      await pumpAndSettleIgnoringImages(tester);

      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text('Generate Share Link'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Back button returns to source screen (e.g., Gallery)', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await pumpAndSettleIgnoringImages(tester);

      AppRouter.router.go('/gallery');
      await pumpAndSettleIgnoringImages(tester);

      AppRouter.router.pushNamed(
        'creation-detail',
        pathParameters: {'creationId': 'user_creation_001'},
      );
      await pumpAndSettleIgnoringImages(tester);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await pumpAndSettleIgnoringImages(tester);

      expect(find.text('My Gallery'), findsOneWidget);
    });

    testWidgets('Back button with source parameter returns to source', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await pumpAndSettleIgnoringImages(tester);

      AppRouter.router.pushNamed(
        'creation-detail',
        pathParameters: {'creationId': 'user_creation_001'},
        queryParameters: {'source': '/explore'},
      );
      await pumpAndSettleIgnoringImages(tester);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await pumpAndSettleIgnoringImages(tester);

      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text('Explore'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Back button returns to Fold Detail if that was the source', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await pumpAndSettleIgnoringImages(tester);

      const origamiId = 'origami_crane';
      AppRouter.router.pushNamed(
        RouteNames.foldDetail,
        pathParameters: {'origamiId': origamiId},
      );
      await pumpAndSettleIgnoringImages(tester);

      AppRouter.router.pushNamed(
        RouteNames.creationDetail,
        pathParameters: {'creationId': 'user_creation_001'},
        queryParameters: {'source': '/fold-detail/$origamiId'},
      );
      await pumpAndSettleIgnoringImages(tester);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await pumpAndSettleIgnoringImages(tester);

      expect(find.text('Paper Crane'), findsOneWidget);
    });
  });
}
