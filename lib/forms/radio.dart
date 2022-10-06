import 'package:flutter/material.dart';

class RadioApp extends StatefulWidget {
  const RadioApp({super.key});

  @override
  State<RadioApp> createState() => _RadioAppState();
}

class _RadioAppState extends State<RadioApp> {
  int selectedRadio = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stateful Builder"),
      ),
      body: Column(
          children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (_, idx) {
            // radio autodetermines its type by value and groupvalue
            // can explicitly declare by Radio<T>
            return RadioListTile(
                value: idx,
                title: Text("select $idx"),
                  
                // the current group value to determine
                // whether this one is selected or not
                groupValue: selectedRadio,
                onChanged: (value) {
                  setState(() {
                    selectedRadio = value!;
                  });
                });
          }),
          Expanded(child: Text("$selectedRadio"))
        ]),
    );
  }
}
