import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TransformApp extends StatelessWidget {
  const TransformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transform app'),),
      body: Transform(
        alignment: Alignment.topRight,
        transform: Matrix4.rotationZ(-pi / 4.0),
        child: Container(
          color: Colors.red,
          child: const Text("hahaha"),
        ),
      ),
    );
  }
}