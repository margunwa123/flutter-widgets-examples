import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class VisualDensityApp extends StatefulWidget {
  const VisualDensityApp({super.key});

  @override
  State<VisualDensityApp> createState() => _VisualDensityAppState();
}

class _VisualDensityAppState extends State<VisualDensityApp> {
  bool touchMode = false;
  
  @override
  Widget build(BuildContext context) {
    double densityAmt = touchMode ? 0.0 : -2.0;

    VisualDensity density = VisualDensity(horizontal: densityAmt, vertical: densityAmt);

    return MaterialApp(
      theme: ThemeData(visualDensity: density),
      home: Scaffold(
        appBar: AppBar(title: const Text("Visual Density App")),
        body: Column(
          children: List.generate(10, (index) => ListTile(title: Text("item: $index"),)),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.settings),
          onPressed: () {
            setState(() {
              touchMode = !touchMode;
            });
          }
        ),
      ),
    );
  }
}