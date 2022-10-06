import 'package:flutter/material.dart';

class OnChangeApp extends StatefulWidget {
  const OnChangeApp({super.key});

  @override
  State<OnChangeApp> createState() => _OnChangeAppState();
}

class _OnChangeAppState extends State<OnChangeApp> {
  final _formKey = GlobalKey<FormState>();
  final fieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    fieldController.addListener(printLatestValue);
  }

  @override
  void dispose() {
    fieldController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Field Listener App")),
      body: Form(
        key: _formKey,
        child: Column(children: [
        TextFormField(
          decoration: const InputDecoration(
            hintText: "Using fieldController"
          ),
          controller: fieldController,
        ),
        TextFormField(
          decoration: const InputDecoration(
            hintText: "Using onChange"
          ),
          onChanged: (text) {
            print("onChange: $text");
          },
        )
      ],))
    );
  }

  void printLatestValue() {
    print('fieldController: ${fieldController.text}');
  }
}