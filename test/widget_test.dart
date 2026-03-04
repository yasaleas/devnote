import 'package:flutter_test/flutter_test.dart';
import 'package:devnote/main.dart';

void main() {
  testWidgets('App starts smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DevNoteApp());

    // Verify that the title "DevNote" is displayed.
    expect(find.text('DevNote'), findsOneWidget);
  });
}
