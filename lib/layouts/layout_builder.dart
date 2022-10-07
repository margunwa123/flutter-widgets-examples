import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LayoutBuilderApp extends StatelessWidget {
  const LayoutBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Layout builder app"),),
      body: Column(
        children: [
          const Text("Try to rotate the phone"),
          Expanded(
            child: Center(
              child: LayoutBuilder(
                builder: (context, BoxConstraints constraint) {
                  if(constraint.maxWidth > 600) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        RandomBox(),
                        RandomBox(color: Colors.yellow,),
                      ],
                    );
                  }
                  else {
                    return const RandomBox();
                  }
                }),
            ),
          ),
        ],
      ),
    );
  }
}

class RandomBox extends StatelessWidget {
  const RandomBox({super.key, this.color = Colors.red});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color
      ),
      width: 100,
      height: 100,
    );
  }
}
