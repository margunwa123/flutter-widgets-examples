import 'package:flutter/material.dart';

class GridApp extends StatelessWidget {
  const GridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Orientation App")),
      body: Container(
        decoration: BoxDecoration(color: Colors.blue.shade50),
        child: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.landscape ? 3 : 2,
            children: const [
              Text("try"),
              Text("rotating"),
              Text("the"),
              Text("app"),
              Text("to"),
              Text("see"),
              Text("tile"),
              Text("change"),
            ],
          );
        },
      )    )
      ); }
}