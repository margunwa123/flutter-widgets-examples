import 'package:flutter/material.dart';

class SnackBarApp extends StatefulWidget {
  const SnackBarApp({super.key});

  @override
  State<SnackBarApp> createState() => _SnackBarAppState();
}

class _SnackBarAppState extends State<SnackBarApp> {
  String _text = "haha hihi";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Snackbar Demo")
      ),
      body: Center( child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_text),
          ElevatedButton(onPressed: displaySnackbar,
            child: const Text("Display snackbar")
            ),
        ]
      )),
    );
  }

  void displaySnackbar() {
    final snackbar = SnackBar(content: const Text("Hello World"),
    action: SnackBarAction(label: "Undo", onPressed: () {
      setState(() {
        _text = "pressed undo";
      });
    }),);
    
    ScaffoldMessenger.of(context).showSnackBar(snackbar).closed.then((value) => {
      setState(() {
        _text = "closed snackbar";
      })
    });
  }
}