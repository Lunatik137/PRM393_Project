import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/core/navigation/app_router.dart';
import 'package:origami_master/core/navigation/route_names.dart';
import 'package:origami_master/core/services/auth_service.dart';
import 'package:origami_master/core/services/creation_service.dart';
import 'package:origami_master/core/services/share_link_service.dart';
import 'package:origami_master/core/theme/app_theme.dart';

void main() {
  String? copiedText;

  setUp(() {
    AuthService.instance.setLoggedIn(true);
    AuthService.instance.setDelay(Duration.zero);
    CreationService.instance.reset();
    ShareLinkService.instance.reset();
    AppRouter.reset();
    copiedText = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
          if (call.method == 'Clipboard.setData') {
            final data = Map<String, dynamic>.from(call.arguments as Map);
            copiedText = data['text'] as String?;
          }
          return null;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null);
  });

  Widget createTestWidget() {
    return MaterialApp.router(
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }

  Future<void> openSharedLinks(
    WidgetTester tester, {
    String source = RouteNames.profile,
    String? creationId,
  }) async {
    await tester.pumpWidget(createTestWidget());
    await pumpAndSettleIgnoringImages(tester);

    final queryParameters = {'source': source};
    if (creationId != null) {
      queryParameters['creationId'] = creationId;
    }

    AppRouter.router.goNamed(
      RouteNames.sharedLinks,
      queryParameters: queryParameters,
    );
    await pumpAndSettleIgnoringImages(tester);
  }

  Finder cardFor(String foldName) {
    return find.ancestor(of: find.text(foldName), matching: find.byType(Card));
  }

  group('SharedLinksScreen Widget Tests', () {
    testWidgets('active link copy copies URL and confirms', (tester) async {
      await openSharedLinks(tester);

      final activeCard = cardFor('My First Crane');
      await tester.tap(
        find.descendant(of: activeCard, matching: find.byTooltip('Copy Link')),
      );
      await tester.pump();

      expect(copiedText, 'https://origami.master/share/active_token_abc');
      expect(find.text('Link copied to clipboard!'), findsOneWidget);
    });

    testWidgets('disabled link copy is disabled', (tester) async {
      await openSharedLinks(tester);

      final disabledCard = cardFor('Summer Lotus');
      final copyButton = tester.widget<IconButton>(
        find.descendant(
          of: disabledCard,
          matching: find.byWidgetPredicate(
            (widget) => widget is IconButton && widget.tooltip == 'Copy Link',
          ),
        ),
      );

      expect(copyButton.onPressed, isNull);
      expect(copiedText, isNull);
    });

    testWidgets('delete active link requires confirmation', (tester) async {
      await openSharedLinks(tester);

      final activeCard = cardFor('My First Crane');
      await tester.tap(
        find.descendant(
          of: activeCard,
          matching: find.byTooltip('Delete Link'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Disable Link?'), findsOneWidget);
      expect(
        find.text('This shared link will stop opening your creation.'),
        findsOneWidget,
      );
    });

    testWidgets('confirmed delete refreshes status to disabled', (
      tester,
    ) async {
      await openSharedLinks(tester);

      final activeCard = cardFor('My First Crane');
      await tester.tap(
        find.descendant(
          of: activeCard,
          matching: find.byTooltip('Delete Link'),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Disable'));
      await pumpAndSettleIgnoringImages(tester);

      final refreshedCard = cardFor('My First Crane');
      expect(
        find.descendant(of: refreshedCard, matching: find.text('Disabled')),
        findsOneWidget,
      );
      expect(find.text('Link disabled'), findsOneWidget);

      final links = await ShareLinkService.instance.getShareLinksByCreationId(
        'user_creation_001',
      );
      expect(links.single.isActive, isFalse);
    });

    testWidgets('tapping active card opens Shared Creation', (tester) async {
      await openSharedLinks(tester);

      await tester.tap(cardFor('My First Crane'));
      await pumpAndSettleIgnoringImages(tester);

      expect(find.text('Origami Master'), findsOneWidget);
      expect(find.text('My First Crane'), findsOneWidget);
    });

    testWidgets('back returns to Profile by source', (tester) async {
      await openSharedLinks(tester, source: RouteNames.profile);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await pumpAndSettleIgnoringImages(tester);

      expect(find.text('Hiroshi Sato'), findsOneWidget);
      expect(find.text('My Shared Links'), findsOneWidget);
    });

    testWidgets('back returns to Generate Share Link by source', (
      tester,
    ) async {
      await openSharedLinks(
        tester,
        source: RouteNames.generateShareLink,
        creationId: 'user_creation_001',
      );

      await tester.tap(find.byIcon(Icons.arrow_back));
      await pumpAndSettleIgnoringImages(tester);

      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text('Generate Share Link'),
        ),
        findsOneWidget,
      );
    });
  });
}

Future<void> pumpAndSettleIgnoringImages(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
  while (tester.takeException() != null) {}
}
