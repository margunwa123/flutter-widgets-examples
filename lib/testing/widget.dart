import 'package:flutter/material.dart';

class WidgetApp extends StatelessWidget {
  const WidgetApp({super.key, required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(child: Text(text)),
      )
    );
  }
}