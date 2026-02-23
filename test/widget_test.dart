import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_vibe_coding/main.dart';

void main() {
  testWidgets('Kanji App builds', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const N5KanjiApp());

    // Verify that the title is displayed
    expect(find.text('JLPT N5\nMastery'), findsOneWidget);
  });
}
