import 'package:flutter/material.dart';

class CustomPaintWidget extends StatelessWidget {
  const CustomPaintWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lines"),
      ),
      body: CustomPaint(
        // painter: ShapePainter(),
        child: Container(),
      ),
    );
  }
}
