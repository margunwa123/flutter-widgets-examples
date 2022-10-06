// an alternative of creating a stateful widget

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class StatefulBuilderApp extends StatelessWidget {
  const StatefulBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stateful Builder"),),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                int number = 0;

                return AlertDialog(
                  content: StatefulBuilder(
                    builder: ((context, setState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List<Widget>.generate(
                          5, (index) {
                            if(index == 4) {
                              return Text("Current value : $number");
                            }
                            return RadioListTile(
                              title: Text("$index"),
                              value: index, 
                              groupValue: number, 
                              onChanged: (idx) {
                                setState(() {
                                  number = idx!;
                                });
                              }
                            );
                          }
                        ),
                        /**
                         * ListView.builder(
                         * itemCount: 4,
                         * itemBuilder: (ctx, index){
                         *   return ListTile(title: Text("$index"));
                         * })
                         */
                      );
                    }),
                  )
                  
                );
              }
            );
          },
          child: const Text("Show options"),
        ),
      ),
    );
  }
}