import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/core/navigation/app_router.dart';
import 'package:origami_master/core/services/auth_service.dart';
import 'package:origami_master/core/services/learning_service.dart';
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

  group('LearningStepScreen Widget Tests', () {
    testWidgets('renders first step correctly and disables Previous button', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await LearningService.instance.saveProgress(
        origamiId: 'origami_crane',
        currentStep: 1,
        totalSteps: 4,
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      AppRouter.router.pushNamed(
        'learning-step',
        pathParameters: {'origamiId': 'origami_crane'},
      );
      await tester.pumpAndSettle();

      expect(find.text('Step 1 of 4'), findsOneWidget);
      expect(find.text('Initial Fold'), findsOneWidget);

      final previousButton = tester.widget<OutlinedButton>(
        find.descendant(
          of: find.byType(Row),
          matching: find.byType(OutlinedButton),
        ),
      );
      expect(previousButton.onPressed, isNull);

      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets('navigates to next step and enables Previous button', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      AppRouter.router.pushNamed(
        'learning-step',
        pathParameters: {'origamiId': 'origami_crane'},
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.text('Step 2 of 4'), findsOneWidget);
      expect(find.text('Square Base'), findsOneWidget);

      final previousButton = tester.widget<OutlinedButton>(
        find.descendant(
          of: find.byType(Row),
          matching: find.byType(OutlinedButton),
        ),
      );
      expect(previousButton.onPressed, isNotNull);
    });

    testWidgets('resumes from saved progress', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await LearningService.instance.saveProgress(
        origamiId: 'origami_crane',
        currentStep: 3,
        totalSteps: 4,
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      AppRouter.router.pushNamed(
        'learning-step',
        pathParameters: {'origamiId': 'origami_crane'},
      );
      await tester.pumpAndSettle();

      expect(find.text('Step 3 of 4'), findsOneWidget);
      expect(find.text('Petal Fold'), findsOneWidget);
    });

    testWidgets(
      'shows Finish on final step and navigates to Completion Result',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await LearningService.instance.saveProgress(
          origamiId: 'origami_crane',
          currentStep: 4,
          totalSteps: 4,
        );

        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        AppRouter.router.pushNamed(
          'learning-step',
          pathParameters: {'origamiId': 'origami_crane'},
        );
        await tester.pumpAndSettle();

        expect(find.text('Step 4 of 4'), findsOneWidget);
        expect(find.text('Finish'), findsOneWidget);

        await tester.tap(find.text('Finish'));
        await tester.pumpAndSettle();

        expect(
          find.text('This is the Completion Result Screen'),
          findsOneWidget,
        );
      },
    );
  });
}
