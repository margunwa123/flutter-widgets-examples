import 'package:flutter/material.dart';

class ValidationApp extends StatefulWidget {
  const ValidationApp({super.key});

  @override
  State<ValidationApp> createState() => _ValidationAppState();
}

class _ValidationAppState extends State<ValidationApp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Validation App"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                child: const Text("Submit"),
                onPressed: () {
                  if (_formKey.currentState == null) return;
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Submitted the form")));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
