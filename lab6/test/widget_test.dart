// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:lab6/main.dart';

void main() {
  testWidgets('Master Plan app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MasterPlanApp());

    // Verify that the Master Plans screen loads.
    expect(find.text('Master Plans'), findsOneWidget);
    expect(find.text('Add a plan'), findsOneWidget);
    expect(find.text('You do not have any plans yet.'), findsOneWidget);
  });
}
