import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: "Testing App",
      home: TestApp(),
    )
  );
}

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("App to be tested"),
      ),
      body: Center(
        child: Column(
          children: [
            Text('$counter'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              key: const Key('increment'), 
              child: const Text("Increment"),
            )
          ],
        ),
      ),
    );
  }
}