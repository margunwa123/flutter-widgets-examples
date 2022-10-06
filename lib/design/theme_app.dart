import 'package:flutter/material.dart';

void runThemedApp() {
  runApp(MaterialApp(
      title: "Hehehe",
      theme: ThemeData(
          // dark / light app
          brightness: Brightness.dark,
          primaryColor: Colors.red,
          fontFamily: 'Georgia',
          appBarTheme: const AppBarTheme(color: Colors.amber),
          textTheme: const TextTheme(
              headline6: TextStyle(fontStyle: FontStyle.italic),
              headline1: TextStyle(fontStyle: FontStyle.normal))),
      home: ThemedApp()));
}

class ThemedApp extends StatelessWidget {
  const ThemedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello world",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: const AnApp(),
    );
  }
}

// we need to separate the material app
// and the actual class to get the context
class AnApp extends StatelessWidget {
  const AnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Text(
        "Hehehe",
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
