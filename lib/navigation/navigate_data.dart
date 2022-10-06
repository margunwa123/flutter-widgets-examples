// this file doesn't completely follow the material
// the material uses stateful widget while this one
// uses workarounds to make stateless widget works too
// to see the tutorial go to 
// https://docs.flutter.dev/cookbook/navigation/returning-data
import 'package:flutter/material.dart';

class NavigateDataApp extends StatelessWidget {
  const NavigateDataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Navigate with data demo")),
      body: Center(child: ElevatedButton(child: Text("Go to selection"), onPressed: () => showSelections(context)),)
    );
  }

  // stateless widget is always mounted
  Future<void> showSelections(BuildContext context, [bool mounted = true]) async {
    final choice = await  Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const SelectionPage(text: "Hello world");
    }));

    if(!mounted) return;

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(choice)));
  }
}

class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select your choice")),
      body: Column(
        children: [
          Text(text),
          ElevatedButton(onPressed: () {
            Navigator.pop<String>(context, "First");
          }, child: const Text("First")),
          ElevatedButton(onPressed: () {
            Navigator.pop<String>(context, "Second");
          }, child: const Text("Second"))
        ],
      ),
    );
  }
}
