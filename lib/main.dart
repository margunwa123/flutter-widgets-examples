import 'package:flutter/material.dart';
import 'package:page_route_animation/animation/animation_up_and_down.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
    home: AnimationUpAndDownApp(
      shrinkingStartHeight: 1000,
    ),
  ));
}
