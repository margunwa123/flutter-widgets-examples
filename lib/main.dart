import 'package:flutter/material.dart';
import 'package:page_route_animation/animation/loading_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
    home: LoadingBarPage(),
  ));
}
