import 'package:flutter_test/flutter_test.dart';
import 'package:bookapp/main.dart';

void main() {
  testWidgets('Serene Reader smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SereneReaderApp());

    // Verify that the title is present
    expect(find.text('Serene Reader'), findsOneWidget);
  });
}
