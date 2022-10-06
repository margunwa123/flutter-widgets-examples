import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_route_animation/persistence/sqlite/dog.dart';
import 'package:page_route_animation/persistence/sqlite/dog_controller.dart';

class FutureBuilderApp extends StatefulWidget {
  const FutureBuilderApp({super.key});

  @override
  State<FutureBuilderApp> createState() => _FutureBuilderAppState();
}

class _FutureBuilderAppState extends State<FutureBuilderApp> {
  Future<List<Dog>> dogs = Future.delayed(Duration(seconds: 3), 
    () => [Dog(id: 1, name: "namte", age: 12)]
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Future builder app"),),
      body: FutureBuilder(
        future: dogs,
        builder: ((context, AsyncSnapshot<List<Dog>> snapshot) {
          if(snapshot.hasData) {
            final data = snapshot.data!;
            
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: ((context, index) => ListTile(
                title: Text(data[index].name),
              ))
            );
          }
          if(snapshot.hasError) {
            return Column(
              children: [
                const Center(child: Icon(Icons.do_disturb)),
                Text("Error : ${snapshot.error}")
              ],
            );
          }
    
          return const CircularProgressIndicator();
        })
      ),
    );
  }
}