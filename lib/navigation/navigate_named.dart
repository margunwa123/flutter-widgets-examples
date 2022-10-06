import "package:flutter/material.dart";

void runNavigateThemedApp() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (_) => const NamedScreen(),
      '/second': (_) => const NamedScreenTwo(),
    },
  ));
}

class NamedScreen extends StatelessWidget {
  const NamedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("First Screen"),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/second');
            },
            child: const Text("Go to second screen"),
          ),
        ));
  }
}

class NamedScreenTwo extends StatelessWidget {
  const NamedScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Second Screen"),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: const Text("Go to first screen"),
          ),
        ));
  }
}
