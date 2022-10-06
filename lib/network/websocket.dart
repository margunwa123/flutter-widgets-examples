import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class WebSocketApp extends StatefulWidget {
  const WebSocketApp({super.key});

  @override
  State<WebSocketApp> createState() => _WebSocketAppState();
}

class _WebSocketAppState extends State<WebSocketApp> {
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:10000')
  );
  final random = Random();

  @override
  void initState() {
    super.initState();
  }
  
  @override
  void dispose() {
    channel.sink.close();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebSocketApp"),
      ),
      body: 
      Column(
        children: [
          StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              return Text(snapshot.hasData ? '${snapshot.data}' : '');
            },
          ),
          ElevatedButton(onPressed: () {
            channel.sink.add('Your current number: ${random.nextInt(200)}');
          }, child: const Text("Send soemthing"))

        ],
      )
    );
  }
}