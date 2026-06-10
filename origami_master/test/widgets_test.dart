import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/core/widgets/primary_button.dart';
import 'package:origami_master/core/widgets/visibility_badge.dart';
import 'package:origami_master/core/widgets/app_bottom_navigation.dart';
import 'package:origami_master/core/widgets/creation_card.dart';
import 'package:origami_master/core/widgets/shared_link_card.dart';
import 'package:origami_master/core/theme/app_theme.dart';

void main() {
  Widget wrapWithTheme(Widget child) {
    return MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: child),
    );
  }

  group('PrimaryButton Tests', () {
    testWidgets('button callback is triggered', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        wrapWithTheme(
          PrimaryButton(label: 'Test', onPressed: () => pressed = true),
        ),
      );

      await tester.tap(find.text('Test'));
      expect(pressed, isTrue);
    });

    testWidgets('button shows loading state', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const PrimaryButton(label: 'Test', isLoading: true)),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Test'), findsNothing);
    });
  });

  group('VisibilityBadge Tests', () {
    testWidgets('shows Public when isPublic is true', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const VisibilityBadge(isPublic: true)),
      );

      expect(find.text('Public'), findsOneWidget);
      expect(find.byIcon(Icons.public), findsOneWidget);
    });

    testWidgets('shows Private when isPublic is false', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const VisibilityBadge(isPublic: false)),
      );

      expect(find.text('Private'), findsOneWidget);
      expect(find.byIcon(Icons.lock), findsOneWidget);
    });
  });

  group('AppBottomNavigation Tests', () {
    testWidgets('correct item is selected', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(AppBottomNavigation(currentIndex: 1, onTap: (_) {})),
      );

      final navigationBar = tester.widget<NavigationBar>(
        find.byType(NavigationBar),
      );
      expect(navigationBar.selectedIndex, 1);
    });

    testWidgets('onTap is triggered with correct index', (tester) async {
      int? tappedIndex;
      await tester.pumpWidget(
        wrapWithTheme(
          AppBottomNavigation(
            currentIndex: 0,
            onTap: (index) => tappedIndex = index,
          ),
        ),
      );

      await tester.tap(find.text('Explore'));
      expect(tappedIndex, 1);
    });
  });

  group('CreationCard Tests', () {
    testWidgets('displays correct content', (tester) async {
      final now = DateTime(2023, 10, 20);
      await tester.pumpWidget(
        wrapWithTheme(
          CreationCard(
            foldName: 'My Crane',
            imagePath: 'assets/images/creations/my_crane.jpg',
            isPublic: true,
            completedAt: now,
            onTap: () {},
          ),
        ),
      );

      expect(find.text('My Crane'), findsOneWidget);
      expect(find.text('20/10/2023'), findsOneWidget);
      expect(find.byType(VisibilityBadge), findsOneWidget);
    });
  });

  group('SharedLinkCard Tests', () {
    testWidgets('presents Active state correctly', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          SharedLinkCard(
            foldName: 'Crane',
            url: 'https://link.com',
            isActive: true,
            createdAt: DateTime.now(),
            onCopy: () {},
          ),
        ),
      );

      expect(find.text('Active'), findsOneWidget);
      expect(find.text('Crane'), findsOneWidget);
    });

    testWidgets('presents Disabled state correctly', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          SharedLinkCard(
            foldName: 'Crane',
            url: 'https://link.com',
            isActive: false,
            createdAt: DateTime.now(),
            onCopy: () {},
          ),
        ),
      );

      expect(find.text('Disabled'), findsOneWidget);
    });

    testWidgets('onCopy is triggered', (tester) async {
      bool copied = false;
      await tester.pumpWidget(
        wrapWithTheme(
          SharedLinkCard(
            foldName: 'Crane',
            url: 'https://link.com',
            isActive: true,
            createdAt: DateTime.now(),
            onCopy: () => copied = true,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.copy));
      expect(copied, isTrue);
    });
  });
}
