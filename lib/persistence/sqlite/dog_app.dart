import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_route_animation/persistence/sqlite/dog.dart';
import 'package:page_route_animation/persistence/sqlite/dog_controller.dart';

class DogApp extends StatefulWidget {
  const DogApp({super.key});

  @override
  State<DogApp> createState() => _DogAppState();
}

class _DogAppState extends State<DogApp> {
  late List<Dog> dogs = [];
  int dogCounter = 0;
  static final _dogController = DogController();

  @override
  void initState() {
    super.initState();
    
    _refresh();
  }

  void _refresh() {
    _dogController.dogs().then((value) {
      setState(() {
        dogs = value;
        dogCounter = value.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DogApp")),
      body: Column( children: [
        ElevatedButton(onPressed: _refresh, child: const Text("Refresh")),
        listViewDogs()
      ]),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _dogController.insertDog(Dog(age: 12, name: "poki", id: dogCounter));
        _refresh();
      }),
    );
  }

  Widget listViewDogs() {
    if(dogs.isEmpty) {
      return const Text("There are no dogs currently empty");
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: dogs.length,
      itemBuilder: generateDogTile
    );
  }

  Widget generateDogTile(BuildContext context, int index) {
    Dog dog = dogs[index];

    return ListTile(
      contentPadding: const EdgeInsets.all(5.0),
      title: Text(dog.toString()),
    );
  }
}
