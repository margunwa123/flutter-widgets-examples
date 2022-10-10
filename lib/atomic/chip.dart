import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../layouts/fitted_box.dart';

class ChipApp extends StatelessWidget {
  const ChipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chip application"),
      ),
      body: Center(
        child: Wrap(
          children: [
            const Chip(
              label: Text("Hello world"), 
              avatar: CircleAvatar(
                child: Text("HW", 
                style: TextStyle(
                  fontSize: 12
                ),),
              )
            ),
            const Chip(
              label: Text("Customized chip"), 
              backgroundColor: Colors.amber,
              avatar: CircleAvatar(
                child: Text("HW", 
                style: TextStyle(
                  fontSize: 12
                ),),
              )
            ),
            Chip(
              padding: EdgeInsets.fromLTRB(2, 8, 2, 8),
              label: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(text: "Comedy", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    )),
                    TextSpan(text: "(68,421)", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                    )),
                  ]
                )
              ), 
              backgroundColor: const Color.fromARGB(255, 79,78,79),
              side: BorderSide.none,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(3))
              ),
            ),
            ActionChip(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const FittedBoxApp())
                );
              },
              label: const Text("Action Chip"),
              avatar: const CircleAvatar(
                backgroundImage: NetworkImage(
      'https://pbs.twimg.com/profile_images/949787136030539782/LnRrYf6e_400x400.jpg'
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}