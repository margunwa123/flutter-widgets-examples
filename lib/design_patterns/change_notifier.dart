import 'package:flutter/material.dart';

class CounterBody extends StatelessWidget {
  CounterBody({super.key, required this.counterNotifier});

  ValueNotifier<int> counterNotifier;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("You have hit the button this amount of times:"),
          AnimatedBuilder(animation: counterNotifier, builder: (BuildContext context, Widget? child) {
            return Text('${counterNotifier.value} times');
          })
        ],
      )
    );
  }
}

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  late ValueNotifier<int> _counterNotifier;
  
  @override
  void initState() {
    super.initState();
    _counterNotifier = ValueNotifier(0);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello World")
      ),
      body: Column(
        children:[ CounterBody(counterNotifier: _counterNotifier)
        , AnotherListener(counterNotifier: _counterNotifier)
        ]),
      floatingActionButton: FloatingActionButton(onPressed: incrementCounter),
    );
  }

  void incrementCounter() {
    setState(() {
      _counterNotifier.value++;
    });
  }
}

class AnotherListener extends StatelessWidget {
  AnotherListener({super.key, required this.counterNotifier});

  final ValueNotifier<int> counterNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      width: 50,
      height: 50,
      child: Text(
        "${counterNotifier.value}"
      ),
    );
  }
}
