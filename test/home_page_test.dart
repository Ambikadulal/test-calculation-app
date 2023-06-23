
import 'package:flutter_test/flutter_test.dart';
import 'package:test_calculation/pages/home_page.dart';

void main() {
  testWidgets('MyWidget has a title', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget( HomePage(title: 'Title'));

    // Create the Finders.
    final titleFinder = find.text('Title');
    expect(titleFinder, findsOneWidget);
  });
}
