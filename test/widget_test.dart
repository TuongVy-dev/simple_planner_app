// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:simple_planner_app/main.dart';

void main() {
  testWidgets('Create Plan screen displays its form', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Create Plan'));
    await tester.pumpAndSettle();

    expect(find.text('Create Plan'), findsOneWidget);
    expect(find.text('Plan Title'), findsOneWidget);
    expect(find.text('Choose Date'), findsOneWidget);
    expect(find.text('Choose Time'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
