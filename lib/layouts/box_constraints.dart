import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BoxConstraintsApp extends StatelessWidget {
  const BoxConstraintsApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hahaha"),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 100,
          minWidth: 10
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green
          ),
        ),
      ),
    );
  }
}
