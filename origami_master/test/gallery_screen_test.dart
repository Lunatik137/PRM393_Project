import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/core/navigation/app_router.dart';
import 'package:origami_master/core/services/auth_service.dart';
import 'package:origami_master/core/theme/app_theme.dart';
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

  group('GalleryScreen Widget Tests', () {
    testWidgets('renders all major components', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Navigate to Gallery
      await tester.tap(find.text('Gallery'));
      await tester.pumpAndSettle();

      expect(find.text('My Gallery'), findsOneWidget);
      expect(find.byType(SearchBar), findsOneWidget);
      expect(find.byType(ChoiceChip), findsNWidgets(3)); // All, Public, Private
      expect(find.byType(CreationCard), findsAtLeastNWidgets(1));
    });

    testWidgets('search filters creations by name', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Gallery'));
      await tester.pumpAndSettle();

      // Assuming mock data has 'My First Crane'
      await tester.enterText(find.byType(SearchBar), 'First');
      await tester.pump();

      expect(find.text('My First Crane'), findsOneWidget);
      expect(find.text('Summer Lotus'), findsNothing);
    });

    testWidgets('visibility filters work', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Gallery'));
      await tester.pumpAndSettle();

      // Tap Public filter
      await tester.tap(find.widgetWithText(ChoiceChip, 'Public'));
      await tester.pump();

      // Verify only public items are shown
      final visiblePublic = tester.widgetList<CreationCard>(
        find.byType(CreationCard),
      );
      for (final card in visiblePublic) {
        expect(card.isPublic, isTrue);
      }

      // Tap Private filter
      await tester.tap(find.widgetWithText(ChoiceChip, 'Private'));
      await tester.pump();

      // Verify only private items are shown
      final visiblePrivate = tester.widgetList<CreationCard>(
        find.byType(CreationCard),
      );
      for (final card in visiblePrivate) {
        expect(card.isPublic, isFalse);
      }
    });

    testWidgets('navigates to Creation Detail when card is tapped', (
      tester,
    ) async {
      // Set screen size to ensure all widgets are in viewport
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Gallery'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CreationCard).first);
      await tester.pumpAndSettle();

      expect(find.text('This is the Creation Detail Screen'), findsOneWidget);
    });

    testWidgets('shows empty state for no results', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Gallery'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(SearchBar), 'NonExistentCreation');
      await tester.pump();

      expect(find.text('No creations found'), findsOneWidget);
      expect(
        find.textContaining('Your gallery is looking a bit empty'),
        findsOneWidget,
      );
    });
  });
}
