import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/core/navigation/app_router.dart';
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

  Future<void> pumpAndSettleIgnoringImages(WidgetTester tester) async {
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    while (tester.takeException() != null) {}
  }

  group('GenerateShareLinkScreen Widget Tests', () {
    testWidgets('Initial state shows preview and Generate Link button', (
      tester,
    ) async {
      const creationId = 'user_creation_001';

      await tester.pumpWidget(createTestWidget());
      await pumpAndSettleIgnoringImages(tester);

      AppRouter.router.pushNamed(
        'generate-share-link',
        pathParameters: {'creationId': creationId},
      );
      await pumpAndSettleIgnoringImages(tester);

      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text('Generate Share Link'),
        ),
        findsOneWidget,
      );
      expect(find.text('My First Crane'), findsOneWidget);
      expect(find.text('Privacy Notice'), findsOneWidget);
      expect(find.text('Generate Link'), findsOneWidget);
      expect(find.text('Generated Link'), findsNothing);

      final copyButton = tester.widget<OutlinedButton>(
        find.widgetWithText(OutlinedButton, 'Copy Link'),
      );
      expect(copyButton.onPressed, isNull);
    });

    testWidgets('Generate Link creates unique active links', (tester) async {
      const creationId = 'user_creation_001';

      await tester.pumpWidget(createTestWidget());
      await pumpAndSettleIgnoringImages(tester);

      AppRouter.router.pushNamed(
        'generate-share-link',
        pathParameters: {'creationId': creationId},
      );
      await pumpAndSettleIgnoringImages(tester);

      await tester.tap(find.text('Generate Link'));
      await pumpAndSettleIgnoringImages(tester);

      expect(find.text('Generated Link'), findsOneWidget);
      expect(
        find.textContaining('https://origami.master/share/'),
        findsOneWidget,
      );
      expect(find.text('Copy Link'), findsOneWidget);

      await tester.tap(find.text('Generate Link'));
      await pumpAndSettleIgnoringImages(tester);

      final allLinks = await ShareLinkService.instance
          .getShareLinksByCreationId(creationId);
      final generatedLinks = allLinks
          .where((link) => link.createdAt.year != 2023)
          .toList(growable: false);

      expect(generatedLinks, hasLength(2));
      expect(generatedLinks.every((link) => link.isActive), isTrue);
      expect(generatedLinks.map((link) => link.token).toSet(), hasLength(2));
      expect(generatedLinks.map((link) => link.url).toSet(), hasLength(2));
    });

    testWidgets('Copy Link button copies URL and shows confirmation', (
      tester,
    ) async {
      const creationId = 'user_creation_001';

      await tester.pumpWidget(createTestWidget());
      await pumpAndSettleIgnoringImages(tester);

      AppRouter.router.pushNamed(
        'generate-share-link',
        pathParameters: {'creationId': creationId},
      );
      await pumpAndSettleIgnoringImages(tester);

      await tester.tap(find.text('Generate Link'));
      await pumpAndSettleIgnoringImages(tester);

      await tester.tap(find.text('Copy Link'));
      await tester.pump(); // SnackBar appears

      expect(find.text('Link copied to clipboard!'), findsOneWidget);

      final links = await ShareLinkService.instance.getShareLinksByCreationId(
        creationId,
      );
      final generatedLink = links.last;
      expect(copiedText, generatedLink.url);
    });

    testWidgets('Generated share link is stored as active', (tester) async {
      const creationId = 'user_creation_002';

      await tester.pumpWidget(createTestWidget());
      await pumpAndSettleIgnoringImages(tester);

      AppRouter.router.pushNamed(
        'generate-share-link',
        pathParameters: {'creationId': creationId},
      );
      await pumpAndSettleIgnoringImages(tester);

      await tester.tap(find.text('Generate Link'));
      await pumpAndSettleIgnoringImages(tester);

      final links = await ShareLinkService.instance.getShareLinksByCreationId(
        creationId,
      );

      expect(links, hasLength(1));
      expect(links.single.isActive, isTrue);
      expect(links.single.url, startsWith('https://origami.master/share/'));
    });

    testWidgets('View Shared Links navigates to Shared Links screen', (
      tester,
    ) async {
      const creationId = 'user_creation_001';

      await tester.pumpWidget(createTestWidget());
      await pumpAndSettleIgnoringImages(tester);

      AppRouter.router.pushNamed(
        'generate-share-link',
        pathParameters: {'creationId': creationId},
      );
      await pumpAndSettleIgnoringImages(tester);

      await tester.tap(find.text('View Shared Links'));
      await pumpAndSettleIgnoringImages(tester);

      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text('Shared Links'),
        ),
        findsOneWidget,
      );
    });
  });
}
