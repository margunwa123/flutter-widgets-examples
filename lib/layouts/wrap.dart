import 'package:flutter/material.dart';

class WrapApp extends StatelessWidget {
  const WrapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wrap Application"),
      ),
      body: Wrap(
        // spacing between items on the main alignment
        spacing: 8.0,

        // spacing between items on the cross alignment
        runSpacing: 4.0,
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                padding: const EdgeInsets.all(8),
                width: constraints.maxWidth / 2,
                child: ListTile(title: const Text("Hehehe"), onTap: (){})
              );
            }
          ),
          Chip(
            avatar: CircleAvatar(backgroundColor: Colors.blue.shade900),
            label: const Text("Hamilton")
          ),
          Chip(
            avatar: CircleAvatar(backgroundColor: Colors.blue.shade900),
            label: const Text("Hamilton")
          ),
          Chip(
            avatar: CircleAvatar(backgroundColor: Colors.blue.shade900),
            label: const Text("Hamilton")
          ),
        ],
      ),
    );
  }
}