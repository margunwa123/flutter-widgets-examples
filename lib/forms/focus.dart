import 'package:flutter/material.dart';

class FocusApp extends StatefulWidget {
  const FocusApp({super.key});

  @override
  State<FocusApp> createState() => _FocusAppState();
}

class _FocusAppState extends State<FocusApp> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode.dispose();

    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Focus App")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                decoration: const InputDecoration(hintText: "This is autofocused!"),
              ),
              TextFormField(
                focusNode: _focusNode,
                decoration: const InputDecoration(hintText: "Click fab to focus me!!"),
              )
            ],
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () { 
        _focusNode.requestFocus();
       },
      child: const Icon(Icons.search)),
    );
  }
}