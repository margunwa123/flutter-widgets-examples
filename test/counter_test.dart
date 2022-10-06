import 'package:page_route_animation/testing/counter.dart';
import 'package:test/test.dart';

void main() {
  group('Counter', () {
    test('Counter value should be zero when initialized', () {
      expect(Counter().counter, 0);
    });

    test('Counter value should be incremented', () {
      final counter = Counter();

      counter.increment();

      expect(counter.counter, 1);
    });

    test('Counter value should be decremented', () {
      final counter = Counter();

      counter.decrement();

      expect(counter.counter, -1);
    }); 
  });
}