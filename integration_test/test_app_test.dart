import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:page_route_animation/testing/test_app.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('testing the counter app', () {
    testWidgets('tap on the button, increase the value', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text('0'), findsOneWidget);

      final Finder incrementButton = find.byKey(const Key("increment"));

      await tester.tap(incrementButton);

      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
    });
  });
}