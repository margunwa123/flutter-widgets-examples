import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedContainerApp extends StatefulWidget {
  const AnimatedContainerApp({super.key});

  @override
  State createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  double _width = 50;
  double _height = 50;
  Color _color = Colors.red;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        width: _width,
        height: _height,
        decoration: BoxDecoration(color: _color, borderRadius: _borderRadius),
        curve: Curves.easeOut,
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => animate(context.size!),
        child: const Icon(Icons.play_arrow),
      ),
    );
  }

  void animate(Size size) {
    setState(() {
      final random = Random();

      _width = random.nextInt(size.width.toInt()).toDouble();
      _height = random.nextInt(size.height.toInt()).toDouble();

      _color = Color.fromRGBO(
          random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);

      _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());
    });
  }
}
