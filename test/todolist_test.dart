import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:page_route_animation/testing/todolist.dart';

void main() {
    testWidgets("Add a todo then removes it", (widgetTester) async {
      final text = 'tunak uwah';

      await widgetTester.pumpWidget(const Todolist());

      final textField = find.byType(TextField);
      final button = find.byType(FloatingActionButton);

      await widgetTester.enterText(textField, text);
      await widgetTester.tap(button);

      await widgetTester.pump();

      final todo = find.text(text);
      expect(todo, findsOneWidget);

      await widgetTester.drag(find.byType(Dismissible), const Offset(500.0, 0.0));
      await widgetTester.pumpAndSettle();

      expect(find.text(text), findsNothing);
    });
}