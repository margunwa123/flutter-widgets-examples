import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:page_route_animation/network/album.dart';

Future<Album> fetchAlbum(http.Client client) async {
  final response = await client.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1')
  );

  if(response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  }
  else {
    throw Exception("Album not found");
  }
}