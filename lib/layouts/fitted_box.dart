import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FittedBoxApp extends StatelessWidget {
  const FittedBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fitted Box App")),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.red
        ),
        width: 300,
        height: 400,
        child: FittedBox(
          fit: BoxFit.cover,
          clipBehavior: Clip.hardEdge,
          child: Image.network('https://pbs.twimg.com/profile_images/949787136030539782/LnRrYf6e_400x400.jpg'),
        ),
      ),
    );
  }
}