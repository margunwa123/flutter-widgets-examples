import 'package:flutter/material.dart';
import 'package:page_route_animation/network/mqtt.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
    home: MqttApp(),
  ));
}
