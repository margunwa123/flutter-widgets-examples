import 'package:flutter/material.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drawer App"),
      ),
      body: const Center(
        child: Text("MyPage"),
      ),
      drawer: Drawer(backgroundColor: Colors.blueAccent,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red
            ),
            child: Text("dathahahahaa")
          ),
          ListTile(
            title: const Text("Page One"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("Page Two"),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),),
    );
  }
}