import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  }
  else {
    throw Exception("Failed to fetch album");
  }
}

class Album {
  final int id;
  final int userId;
  final String title;

  Album({
    required this.id,
    required this.title,
    this.userId = 1,
  });

  static Album fromJson(Map<String, dynamic> json) {
    if(json['userId'] == null ) {
      return Album(id: json['id'], title: json['title']);
    }
    return Album(id: json['id'], userId: json['userId'], title: json['title']);
  }
}