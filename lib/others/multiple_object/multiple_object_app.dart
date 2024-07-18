import 'package:flutter/material.dart';

class MultipleObjectApp extends StatefulWidget {
  const MultipleObjectApp({super.key});

  @override
  State<MultipleObjectApp> createState() => _MultipleObjectAppState();
}

class _MultipleObjectAppState extends State<MultipleObjectApp> {
  @override
  void initState() {
    super.initState();
  }

  _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          height: 200,
          child: const Text(
            "duarduarduar",
            key: ValueKey("bro"),
          ),
        );
      },
    );
  }

  final wrapWidget = List.generate(10, (_) => const ObjectWidget());
  final stackW1 = List.generate(3, (_) => const ObjectWidget());
  final stackW2 = List.generate(4, (_) => const ObjectWidget());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Brother"),
      ),
      body: Stack(
        children: [
          Center(
            child: Wrap(
              children: wrapWidget,
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: Row(
              children: stackW1,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3,
            left: MediaQuery.of(context).size.width / 2,
            child: Column(
              children: stackW2,
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.red[100],
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    _showBottomSheet();
                  },
                  child: const Text("Show bottom sheet"),
                ),
              ))
        ],
      ),
    );
  }
}

class ObjectWidget extends StatefulWidget {
  const ObjectWidget({super.key});

  @override
  State<ObjectWidget> createState() => _ObjectWidgetState();
}

class _ObjectWidgetState extends State<ObjectWidget> {
  final tapColors = [
    Colors.white,
    Colors.green[100],
    Colors.green[300],
    Colors.green[500]
  ];
  int tapIndex = 0;
  get tapColor =>
      tapIndex >= tapColors.length ? Colors.black : tapColors[tapIndex];

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Hello",
      child: GestureDetector(
        onTap: () {
          setState(() {
            tapIndex += 1;
          });
        },
        child: Container(
          color: tapColor,
          padding: const EdgeInsets.all(8),
          child: const CircleAvatar(
            child: Text("huhu"),
          ),
        ),
      ),
    );
  }
}
