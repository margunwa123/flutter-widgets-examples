import 'package:flutter/material.dart';

class FormValueApp extends StatefulWidget {
  const FormValueApp({super.key});

  @override
  State<FormValueApp> createState() => _FormValueAppState();
}

class _FormValueAppState extends State<FormValueApp> {
  final _fieldController = TextEditingController();
  String value = "";

  @override
  void initState() {
    super.initState();
    _fieldController.addListener(() {
      setState(() {
      value = _fieldController.text;
      });
    });
  }

  @override
  void dispose() {
    _fieldController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Value App"),),
      body: Center(child: 
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(
          decoration: const InputDecoration(
            hintText: "Try typing here"
          ),
          controller: _fieldController,
        ),
        Text(value)
      ],)),
    );
  }
}