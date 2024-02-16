import 'package:flutter/material.dart';

class NotchCardLineWidget extends StatelessWidget {
  const NotchCardLineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 24,
        height: 4,
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}
