import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SpacerApp extends StatelessWidget {
  const SpacerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Spacer App")),
      body: Column(
        children: const <Widget>[
          Text("I'm on top"),
          Spacer(),
          Text("I'm on bottom")
        ],
      ),
    );
  }
}