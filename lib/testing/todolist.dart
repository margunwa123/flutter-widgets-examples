import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  List<String> todos = [];
  TextEditingController textBinding = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todolist",
      home: Scaffold(
        appBar: AppBar(title: const Text("Todolist"),),
        body: Column(
          children: [
            TextField(
              controller: textBinding,
            ),
            Expanded(child: 
              ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                final String todo = todos[index];

                return Dismissible(
                  key: Key("$todo$index"),
                  child: Text(todo),
                  onDismissed: (_) => todos.removeAt(index),
                  background: Container(color: Colors.red),
                );
              })
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          setState(() {
            todos.add(textBinding.text);
            textBinding.clear();
          });
        }
        ,
        child: const Icon(Icons.add),),
      ),
    );
  }
}