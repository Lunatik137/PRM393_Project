import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/core/navigation/app_router.dart';
import 'package:origami_master/core/services/auth_service.dart';
import 'package:origami_master/core/theme/app_theme.dart';
import 'package:origami_master/data/mock/mock_data.dart';
import 'package:origami_master/features/home/presentation/widgets/continue_learning_card.dart';
import 'package:origami_master/core/widgets/origami_card.dart';
import 'package:origami_master/core/widgets/creation_card.dart';

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

  group('HomeScreen Widget Tests', () {
    testWidgets('renders all major sections', (tester) async {
      // Set screen size to ensure all widgets are in viewport
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Featured Fold'), findsOneWidget);
      expect(find.text('Resume Progress'), findsOneWidget);
      expect(find.text('Recent Community Creations'), findsOneWidget);
      expect(find.byType(OrigamiCard), findsOneWidget);
      expect(find.byType(ContinueLearningCard), findsOneWidget);
      expect(find.byType(CreationCard), findsAtLeastNWidgets(1));
    });

    testWidgets('filters only public community creations', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final publicCount = MockData.communityCreations
          .where((c) => c.isPublic)
          .length;
      final visibleCreations = tester.widgetList<CreationCard>(
        find.byType(CreationCard),
      );

      expect(visibleCreations.length, equals(publicCount.clamp(0, 5)));
      for (final widget in visibleCreations) {
        expect(widget.isPublic, isTrue);
      }
    });

    testWidgets('navigates to Fold Detail when featured fold is tapped', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(OrigamiCard));
      await tester.pumpAndSettle();

      expect(find.text('This is the Fold Detail Screen'), findsOneWidget);
    });

    testWidgets('navigates to Learning Step when continue learning is tapped', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ContinueLearningCard));
      await tester.pumpAndSettle();

      expect(find.text('This is the Learning Step Screen'), findsOneWidget);
    });

    testWidgets('navigates to Creation Detail when community card is tapped', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CreationCard).first);
      await tester.pumpAndSettle();

      expect(find.text('This is the Creation Detail Screen'), findsOneWidget);
    });

    testWidgets('bottom navigation works', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Tap Explore
      await tester.tap(find.text('Explore'));
      await tester.pumpAndSettle();
      expect(find.text('This is the Explore Screen'), findsOneWidget);

      // Tap Gallery
      await tester.tap(find.text('Gallery'));
      await tester.pumpAndSettle();
      expect(find.text('This is the Gallery Screen'), findsOneWidget);

      // Tap Profile
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('This is the Profile Screen'), findsOneWidget);

      // Tap Home again
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.text('Featured Fold'), findsOneWidget);
    });
  });
}
