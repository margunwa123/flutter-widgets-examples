import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AlignApp extends StatelessWidget {
  const AlignApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Align")),
      body: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.red
          ),
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}