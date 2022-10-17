import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:page_route_animation/design_patterns/change_notifier.dart';

void main() {
  testWidgets('Counter golden test', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CounterApp()));

    expectLater(find.byType(CounterApp), matchesGoldenFile('counter_app.png'));
  });
}
