import 'package:flutter/material.dart';

class TextFieldFocus extends StatefulWidget {
  const TextFieldFocus({super.key});

  @override
  State<TextFieldFocus> createState() => _TextFieldFocusState();
}

class _TextFieldFocusState extends State<TextFieldFocus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          alignment: Alignment.center,
          color: Colors.green,
          child: const TextField(),
        ),
      ),
    );
  }
}
