import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class IsolateNetworkApp extends StatefulWidget {
  const IsolateNetworkApp({super.key});

  @override
  State<IsolateNetworkApp> createState() => _IsolateNetworkAppState();
}

class _IsolateNetworkAppState extends State<IsolateNetworkApp> {
  late final Future<List<Photo>> futurePhotos;
  
  @override
  void initState() {
    super.initState();

    futurePhotos = fetchPhotos();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Isolate App")),
      body: FutureBuilder(future: futurePhotos, builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        if(snapshot.hasData) {
          final photos = snapshot.data;

          if(photos == null) {
            return Text("No photos");
          }
          
          return ListView.builder(itemCount: photos.length, itemBuilder: ((context, index) {
            final photo = photos[index];

            return ListTile(
              title: Text(photo.title),
            );
          }));
        }

        return const CircularProgressIndicator();
      }),
    );
  }
}

Future<List<Photo>> fetchPhotos() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

  if(response.statusCode == 200) {
    return compute(parsePhotos, response.body);
  }
  else {
    throw Exception("Error while fetching photos");
  }
}

List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;
  
  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  static Photo fromJson(Map<String, dynamic> json) {
    return Photo(albumId: json["albumId"], id: json["id"], title: json["title"], url: json["url"], thumbnailUrl: json["thumbnailUrl"]);
  }
}
