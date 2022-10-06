import 'package:flutter/material.dart';
import 'package:page_route_animation/persistence/keyvalue/counter_store.dart';

class KeyValue extends StatefulWidget {
  const KeyValue({super.key});

  @override
  State<KeyValue> createState() => _KeyValueState();
}

enum LoadingState {
  loading,
  finished
}

class _KeyValueState extends State<KeyValue> {
  final CounterKeyValue _store = CounterKeyValue();
  late int counter = 0;
  LoadingState _loadingState = LoadingState.loading;

  @override
  void initState() {
    super.initState();
    _store.getCounter().then((value) => {
      setState(() {
        counter = value;
        _loadingState = LoadingState.finished;
      })
    });
  }

  @override
  void dispose() {
    super.dispose();
    _store.saveCounter(counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter keyvalue store"),
        actions: [
          IconButton(onPressed: () => gotoSecondScreen(context), icon: const Icon(Icons.arrow_right_outlined))
        ],
      ),
      body: Center(child: _loadingState != LoadingState.loading ? Text("$counter") : const Text("Please wait a bit...")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () { 
          setState(() {
            counter++; 
            _store.saveCounter(counter);
          });
        },
      ),
    );
  }

  void gotoSecondScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return SecondScreen();
    }));
  }
}

class SecondScreen extends StatelessWidget {
  SecondScreen({super.key});
  
  final CounterKeyValue _store = CounterKeyValue();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Screen")),
      body: Center(child: ElevatedButton(child: Text("Get counter value"), onPressed: () => showCounter(context)),),
    );
  }

  void showCounter(BuildContext context) {
    _store.getCounter().then((value) {
      final snackBar = SnackBar(content: Text("$value"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
