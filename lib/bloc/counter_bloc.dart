import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CounterEvent {}

class CounterIncrementEvent extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementEvent>((event, emit) {
      emit(state + 1);
    });
  }
}

class TextBlocEvent {}

class TextBlocChangeEvent extends TextBlocEvent {}

class TextBloc extends Bloc<TextBlocEvent, String> {
  TextBloc(String initialState) : super(initialState);
}

void runCounterBlocApp() {
  runApp(MaterialApp(
    home: BlocProvider(
      create: (ctx) => CounterBloc(),
      child: const CounterBlocApp(), //scaffoldnya
    ),
  ));
}

class CounterBlocApp extends StatelessWidget {
  const CounterBlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The Application Bar"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            BlocProvider.of<CounterBloc>(context).add(CounterIncrementEvent());
          }),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You have pressed the button this many times:"),
            BlocBuilder<CounterBloc, int>(builder: (context, state) {
              return Text(
                "${state}",
                style: const TextStyle(fontSize: 24),
              );
            }),
            const Text("Multiplied by 5"),
            BlocSelector<CounterBloc, int, int>(
              selector: (state) {
                return state * 5;
              },
              builder: (context, state) => Text("$state"),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return BlocProvider.value(
                        // Bloc provider will give state to the second screen
                        value: BlocProvider.of<CounterBloc>(context),
                        child: const SecondScreen());
                  }));
                },
                child: Text("Go to screen 2"))
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello world"),
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, int>(builder: (context, state) {
          return Text("$state");
        }),
      ),
    );
  }
}
