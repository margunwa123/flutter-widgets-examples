import 'dart:math';

import 'package:flutter/material.dart';

class LimitedBoxApp extends StatelessWidget {
  const LimitedBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Limited Box Application")),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (ctx, idx) {
          return LimitedBox(
            maxHeight: 100,
            child: Container(
            decoration: BoxDecoration(
              color: randomColor()
            ),
          ));
        }),
    );
  }
}

Color randomColor() {
  final random = Random();
  int r = random.nextInt(255);
  int g = random.nextInt(255);
  int b = random.nextInt(255);

  return Color.fromARGB(255, r, g, b);
}
