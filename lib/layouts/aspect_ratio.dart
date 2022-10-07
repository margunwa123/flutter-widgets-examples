import 'dart:async';

import 'package:flutter/material.dart';

class AspectRatioApp extends StatefulWidget {
  const AspectRatioApp({super.key});

  @override
  State<AspectRatioApp> createState() => _AspectRatioAppState();
}

class _AspectRatioAppState extends State<AspectRatioApp> {
  double ratio = 1;
  late Timer _timer;
  bool incrementing = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aspect ratio app"),),
      body: Center(
        child: AspectRatio(
          // width / height
          aspectRatio: ratio,

          // this redbox will get stretched to fill the space of
          // its container
          child: const RedBox(),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTapDown: (detail) => _intervalRatio(),
        onTapUp: (detail) => _stopInterval(),
        
        child: Icon(Icons.add)
      )
    );
  }

  _stopInterval() {
    _timer.cancel();
  }

  _intervalRatio() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) { 
      if(ratio >= 2) {
        incrementing = false;
      }
      else if (ratio <= 1) {
        incrementing = true;
      }
      setState(() {
        ratio += incrementing ? 0.1 : -0.1;
      });
    });
  }
}

class RedBox extends StatelessWidget {
  const RedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
      ),

      // this 2 properties doesn't matter
      width: 100,
      height: 100,
    );
  }
}