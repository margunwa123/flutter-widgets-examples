import 'package:flutter/material.dart';

class AnimatedOpacityApp extends StatefulWidget {
  const AnimatedOpacityApp({super.key});

  @override
  State<AnimatedOpacityApp> createState() => _AnimatedOpacityAppState();
}

class _AnimatedOpacityAppState extends State<AnimatedOpacityApp> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(seconds: 1),
          child: Container(
            width: 200,
            height: 200,
            color: Colors.green,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: animate,
        child: const Icon(Icons.flip),
      ),
    );
  }

  void animate() {
    setState(() {
      _visible = !_visible;
    });
  }
}
