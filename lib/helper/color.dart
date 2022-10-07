
import 'dart:math';
import 'dart:ui';

Color randomColor() {
  final random = Random();
  int r = random.nextInt(255);
  int g = random.nextInt(255);
  int b = random.nextInt(255);

  return Color.fromARGB(255, r, g, b);
}