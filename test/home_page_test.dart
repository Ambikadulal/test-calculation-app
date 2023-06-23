
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_calculation/pages/home_page.dart';
import 'package:test_calculation/pages/widget/button_widget.dart';

void main() {
  testWidgets('MyWidget has a title', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget( HomePage(title: 'Title'));

    // Create the Finders.
    final titleFinder = find.text('Title');
    expect(titleFinder, findsOneWidget);
    // Enter 'textInput' into the TextFormField.
     tester.testTextInput;

    // Tap the add button.
    await tester.tap(find.byType(ButtonWidget));

    // Rebuild the widget with the new item.
    await tester.pump();

    // Expect to find the first widget on screen.
     tester.firstWidget(find.byType(TextFormField));

    // Build the widget until the dismiss animation ends.
    await tester.pumpAndSettle();

    // Ensure that the item is no longer on screen.
    expect(find.text('0'), findsNothing);
  });

}
