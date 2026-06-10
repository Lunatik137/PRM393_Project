import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/core/navigation/app_router.dart';
import 'package:origami_master/core/services/auth_service.dart';
import 'package:origami_master/core/theme/app_theme.dart';
import 'package:origami_master/core/widgets/creation_card.dart';
import 'package:origami_master/data/mock/mock_data.dart';
import 'package:origami_master/features/origami/presentation/screens/fold_detail_screen.dart';

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

  group('FoldDetailScreen Widget Tests', () {
    testWidgets('renders all major components for Paper Crane', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle(); // Wait for Splash and Home

      // Use pushNamed to go to Fold Detail
      AppRouter.router.pushNamed(
        'fold-detail',
        pathParameters: {'origamiId': 'origami_crane'},
      );
      await tester.pumpAndSettle();

      final foldDetail = find.byType(FoldDetailScreen);
      expect(foldDetail, findsOneWidget);

      // Verify header components
      expect(
        find.descendant(of: foldDetail, matching: find.text('Paper Crane')),
        findsAtLeastNWidgets(1),
      );
      expect(
        find.descendant(of: foldDetail, matching: find.text('Traditional')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: foldDetail, matching: find.text('Medium')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: foldDetail, matching: find.text('10 mins')),
        findsOneWidget,
      );

      // Verify body sections
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('Materials'), findsOneWidget);
      expect(find.text('Square paper'), findsOneWidget);
      expect(find.text('Step Preview'), findsOneWidget);
      expect(find.text('Initial Fold'), findsOneWidget);

      // Verify Start Learning button (now in bottomNavigationBar)
      expect(find.text('Start Learning'), findsOneWidget);
    });

    testWidgets('community gallery filters matching public creations', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final origamiId = 'origami_crane';
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      AppRouter.router.pushNamed(
        'fold-detail',
        pathParameters: {'origamiId': origamiId},
      );
      await tester.pumpAndSettle();

      final foldDetail = find.byType(FoldDetailScreen);
      final matchingPublicCount = MockData.communityCreations
          .where((c) => c.isPublic && c.origamiId == origamiId)
          .length;

      expect(
        find.descendant(of: foldDetail, matching: find.byType(CreationCard)),
        findsNWidgets(matchingPublicCount),
      );
    });

    testWidgets('navigates to Learning Step when Start Learning is tapped', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      AppRouter.router.pushNamed(
        'fold-detail',
        pathParameters: {'origamiId': 'origami_crane'},
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Start Learning'));
      await tester.pumpAndSettle();

      expect(find.text('This is the Learning Step Screen'), findsOneWidget);
    });

    testWidgets('navigates to Creation Detail when community card is tapped', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      AppRouter.router.pushNamed(
        'fold-detail',
        pathParameters: {'origamiId': 'origami_crane'},
      );
      await tester.pumpAndSettle();

      final foldDetail = find.byType(FoldDetailScreen);
      await tester.tap(
        find
            .descendant(of: foldDetail, matching: find.byType(CreationCard))
            .first,
      );
      await tester.pumpAndSettle();

      expect(find.text('This is the Creation Detail Screen'), findsOneWidget);
    });

    testWidgets('back button returns to previous screen', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      AppRouter.router.pushNamed(
        'fold-detail',
        pathParameters: {'origamiId': 'origami_crane'},
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Should be back at Home
      expect(find.text('Featured Fold'), findsOneWidget);
    });
  });
}
