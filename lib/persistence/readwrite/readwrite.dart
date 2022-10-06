import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CounterReadWrite extends StatefulWidget {
  const CounterReadWrite({super.key});

  @override
  State<CounterReadWrite> createState() => _CounterReadWriteState();
}

class _CounterReadWriteState extends State<CounterReadWrite> {
  int counter = 0;
  CounterSaver _counterSaver = CounterSaver();
  
  @override
  void initState() {
    super.initState();
    _counterSaver.readCounter().then((value) {
      setState(() {
        counter = value;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Read write to documents app")),
      body: Center(
        child: Column(
          children: [
            const Text("Counter:"),
            Text('$counter')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            counter += 1;
          });
          _counterSaver.writeCounter(counter);
        },
      ),
    );
  }
}

class CounterSaver {
  // Documents directory is where appdata is (not the cache)
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/counter.txt');
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    return file.writeAsString('$counter');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();

      return int.parse(contents);
    }
    catch(e) {
      return 0;
    }
  }
}