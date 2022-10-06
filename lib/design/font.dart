import 'package:flutter/material.dart';

class FontApp extends StatelessWidget {
  const FontApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Font App")),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            Text("Hello World", style: TextStyle(
              fontSize: 50
            ),),
            Text("Hello world from Raleway", style: TextStyle(
              fontFamily: "Raleway",
              package: "page_route_animation",
              fontSize: 50
            ),),
          ],
        ),
      )
    );
  }
}