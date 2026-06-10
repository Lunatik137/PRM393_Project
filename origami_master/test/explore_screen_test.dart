import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/core/navigation/app_router.dart';
import 'package:origami_master/core/services/auth_service.dart';
import 'package:origami_master/core/theme/app_theme.dart';
import 'package:origami_master/core/widgets/origami_card.dart';

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

  group('ExploreScreen Widget Tests', () {
    testWidgets('renders all major components', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Navigate to Explore
      await tester.tap(find.text('Explore'));
      await tester.pumpAndSettle();

      expect(find.byType(SearchBar), findsOneWidget);
      expect(
        find.byType(ChoiceChip),
        findsAtLeastNWidgets(2),
      ); // Categories and Difficulties
      expect(find.byType(OrigamiCard), findsAtLeastNWidgets(1));
    });

    testWidgets('search works case-insensitively', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Explore'));
      await tester.pumpAndSettle();

      // Search for 'crane'
      await tester.enterText(find.byType(SearchBar), 'crane');
      await tester.pump();
      expect(find.text('Paper Crane'), findsOneWidget);
      expect(find.text('Jumping Frog'), findsNothing);

      // Search for 'CRANE'
      await tester.enterText(find.byType(SearchBar), 'CRANE');
      await tester.pump();
      expect(find.text('Paper Crane'), findsOneWidget);
    });

    testWidgets('category filter works', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Explore'));
      await tester.pumpAndSettle();

      // Tap 'Flowers' category
      await tester.tap(find.widgetWithText(ChoiceChip, 'Flowers'));
      await tester.pump();

      expect(find.text('Tulip Flower'), findsOneWidget);
      expect(find.text('Water Lotus'), findsOneWidget);
      expect(find.text('Paper Crane'), findsNothing);
    });

    testWidgets('difficulty filter works', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Explore'));
      await tester.pumpAndSettle();

      // Tap 'Hard' difficulty
      await tester.tap(find.widgetWithText(ChoiceChip, 'Hard'));
      await tester.pump();

      expect(find.text('Water Lotus'), findsOneWidget);
      expect(find.text('Paper Crane'), findsNothing);
    });

    testWidgets('combined filtering works', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Explore'));
      await tester.pumpAndSettle();

      // Category: Traditional, Difficulty: Medium
      await tester.tap(find.widgetWithText(ChoiceChip, 'Traditional'));
      await tester.tap(find.widgetWithText(ChoiceChip, 'Medium'));
      await tester.pump();

      expect(find.text('Paper Crane'), findsOneWidget);

      // Add search
      await tester.enterText(find.byType(SearchBar), 'Dragon');
      await tester.pump();
      expect(find.text('Paper Crane'), findsNothing);
      expect(find.text('No models found'), findsOneWidget);
    });

    testWidgets('navigates to Fold Detail when card is tapped', (tester) async {
      // Set screen size to ensure all widgets are in viewport
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Explore'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Paper Crane'));
      await tester.pumpAndSettle();

      expect(find.text('This is the Fold Detail Screen'), findsOneWidget);
      expect(find.text('origamiId: origami_crane'), findsOneWidget);
    });

    testWidgets('shows empty state when no results', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Explore'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(SearchBar), 'NonExistentModel');
      await tester.pump();

      expect(find.text('No models found'), findsOneWidget);
      expect(
        find.text('Try adjusting your filters or search query.'),
        findsOneWidget,
      );
    });
  });
}
