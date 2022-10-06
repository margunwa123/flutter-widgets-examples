import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:http/http.dart' as http;
import 'album.dart';


class SendDataApp extends StatefulWidget {
  const SendDataApp({super.key});

  @override
  State<SendDataApp> createState() => _SendDataAppState();
}

class _SendDataAppState extends State<SendDataApp> {
  List<Album> albums = [Album(id: 1, userId: 1, title: 'haha')];
  final _formKey = GlobalKey<FormState>();
  final titleBinding = TextEditingController();

  @override
  void dispose() {
    titleBinding.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Send Data App")),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(child: TextFormField(
                  controller: titleBinding,
                  decoration: const InputDecoration(
                    hintText: "Album title"
                  ),
                ),),
                ElevatedButton(
                  onPressed: () {
                    if(!_formKey.currentState!.validate()) {
                      return;
                    }

                    createAlbum(titleBinding.text).then((value) {
                      setState(() {
                        albums = [...albums, value];
                      });
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${value.title} created'))
                      );
                    });
                  }, 
                  child: const Text("Create")
                )
              ],
            )
          ),

          Expanded(
            child: ListView.builder(
              itemCount: albums.length,
              itemBuilder: ((context, index) {
                final album = albums[index];

                return ListTile(
                  title: Text(album.title),
                );
              })
            )
          ),
        ]
      )
      
    );
  }
}

Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, String> {
      'title': title
    })
  );

  if(response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body));
  }
  else {
    throw Exception("Error while creating todo");
  }
}