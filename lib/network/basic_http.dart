import 'dart:convert';

import 'package:flutter/material.dart';

import 'album.dart';

class BasicHttpApp extends StatefulWidget {
  const BasicHttpApp({super.key});

  @override
  State<BasicHttpApp> createState() => Basic_HttpAppState();
}

class Basic_HttpAppState extends State<BasicHttpApp> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();

    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hello world")),
      body: FutureBuilder(
        future: futureAlbum,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Text(snapshot.data?.title ?? "No title");
          }
          else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const CircularProgressIndicator();
        }
      ),
    );
  }
}
