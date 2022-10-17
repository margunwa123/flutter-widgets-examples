import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const randomWords = [
  "jenkins",
  "rivel",
  "berthold",
  "hold",
  "event",
  "emitter",
  "casual",
  "robotic",
  "idiotic",
  "idiom",
  "rival",
  "river",
  "eyedropper",
  "drop",
  "eye",
  "dropping",
  "eyelids",
  "head",
  "eye",
  "hair",
  "hairdryer",
  "hair sanitizer",
  "hand",
  "hand sanitizer",
  "sanitize",
  "effect",
  "affect",
  "water",
  "bottle"
];

abstract class TextEvent {
  final String payload;

  TextEvent({required this.payload});
}

class TextChangeEvent extends TextEvent {
  TextChangeEvent(String string) : super(payload: string);
}

class TextBloc extends Bloc<TextEvent, String> {
  TextBloc(String initialState) : super(initialState) {
    on<TextChangeEvent>((event, emit) {
      emit(event.payload);
    });
  }
}

class CounterEvent {}

class CounterIncrementEvent extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementEvent>((event, emit) {
      emit(state + 1);
    });
  }
}

class MultiBlocApp extends StatelessWidget {
  const MultiBlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        child: const MultiBlocScreen(),
        providers: [
          BlocProvider<CounterBloc>(create: (_) => CounterBloc()),
          BlocProvider<TextBloc>(create: (_) => TextBloc("haha"))
        ],
      ),
    );
  }
}

class MultiBlocScreen extends StatefulWidget {
  const MultiBlocScreen({super.key});

  @override
  State<MultiBlocScreen> createState() => _MultiBlocScreenState();
}

class _MultiBlocScreenState extends State<MultiBlocScreen> {
  double containerSizeMultiplier = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("awawa"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocListener<CounterBloc, int>(
              listener: (ctx, state) {
                setState(() {
                  containerSizeMultiplier = 1 + state / 10;
                });
              },
              child: AnimatedContainer(
                width: 100 * containerSizeMultiplier,
                height: 100 * containerSizeMultiplier,
                color: Colors.red,
                duration: const Duration(seconds: 1),
              ),
            ),
            BlocBuilder<TextBloc, String>(builder: (ctx, state) {
              return Text(
                state,
                style: Theme.of(context).textTheme.headlineSmall,
              );
            }),
            BlocBuilder<CounterBloc, int>(builder: (ctx, state) {
              return Text("$state");
            }),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<CounterBloc>(context)
                      .add(CounterIncrementEvent());
                },
                child: Text("inc")),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<TextBloc>(context)
                      .add(TextChangeEvent(_randomizedString()));
                },
                child: const Text("Randomized Word"))
          ],
        ),
      ),
    );
  }

  String _randomizedString() {
    int randomInt = Random().nextInt(randomWords.length);

    return randomWords[randomInt];
  }
}
