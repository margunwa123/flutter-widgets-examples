import 'package:flutter_test/flutter_test.dart';
import 'package:page_route_animation/testing/widget.dart';

void main() {
  group('Home Test', () {
    testWidgets('Check if text is there', (widgetTester) async {
      const text = 'hello world';
      const title = 'hola globe';

      await widgetTester.pumpWidget(const WidgetApp(title: title, text: text));

      final textMatcher = find.text(text);
      final titleMatcher = find.text(text);

      expect(titleMatcher, findsOneWidget);
      expect(textMatcher, findsOneWidget);
    });
  });
}
