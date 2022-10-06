import 'package:flutter/material.dart';

class StyledFieldApp extends StatefulWidget {
  const StyledFieldApp({super.key});

  @override
  State<StyledFieldApp> createState() => _StyledFieldAppState();
}

class _StyledFieldAppState extends State<StyledFieldApp> {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("StyledFieldApp"),),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "First styled text field"
                ),
              ),
              const SizedBox(height: 8.0,),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Second styled text field"
                ),
              )
            ],
        )),
      ),
    );
  }
}