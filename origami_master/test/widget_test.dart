import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/app/app.dart';

void main() {
  testWidgets('App splash screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const OrigamiMasterApp());

    // Verify that splash screen text is shown.
    expect(find.text('Origami Master'), findsOneWidget);

    // Wait for the splash screen timer to finish and the transition to complete
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Verify that login screen is shown (by checking for "Welcome Back" text)
    expect(find.text('Welcome Back'), findsOneWidget);
  });
}
