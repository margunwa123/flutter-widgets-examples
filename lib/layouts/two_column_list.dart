import 'package:flutter/material.dart';

import '../helper/color.dart';

class TwoColumnListApp extends StatelessWidget {
  const TwoColumnListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Two Column List App"),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Wrap(
          runSpacing: 8.0,
          spacing: 8.0,
          children: <Widget>[
            for (var i = 0; i < 10; i++)
              Container(
                decoration: BoxDecoration(color: randomColor()),
                padding: const EdgeInsets.all(8.0),
                width: (constraints.maxWidth / 2) - 8,
                child: ListTile(
                  onTap: () {},
                  title: Text("Something $i"),
                ),
              )
          ],
        );
      }),
    );
  }
}
