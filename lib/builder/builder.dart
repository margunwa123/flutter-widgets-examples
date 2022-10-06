// Builder is a simple inline alternative to creating
// a new stateless widget

// A widget's context refers to the one above it, so
// the context that's passed into a widget's build method
// might not contain some stuff, like *Scaffold* (and that).
// is the case with a lot of widget

// That is why, you must pass a buildcontext that contains
// the class, one of the trick is by using the Builder 
// widget

// Per definition, build context is "a handle to the location
// of a widget in a widget tree", also "Each widget has its own 
// [BuildContext], which becomes the parent of the
// widget returned by the [StatelessWidget.build] or [State.build]"

import 'package:flutter/material.dart';
import 'package:page_route_animation/persistence/sqlite/dog_app.dart';

class BuilderApp extends StatelessWidget {
  const BuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  child: const Text("Without builder"),
                  onPressed: () {
                    // Navigator still exists in the Expanded buildcontext
                    // so this commendted code will not throw any error
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(builder: (ctx) => const DogApp())
                    // );

                    // Scaffold doesn't exist in Expanded buildcontext,
                    // so this will throw an error
                    try {
                      print(Scaffold.of(context).hasAppBar);
                    }
                    catch(err) {
                      print("Errror: $err");
                    }
                  },
              )),
              Expanded(
                child: Builder(
                  builder: (BuildContext context) {
                    return TextButton(
                      onPressed: () {
                        print(Scaffold.of(context).hasAppBar);
                      }, 
                      child: const Text("With builder")
                    );
                  }
                )
              ),
            ],
          ),
        ),
      );
  }
}