import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  increment() => emit(state + 1);
}

class CubitOnChange extends Cubit<int> {
  CubitOnChange(int initialState) : super(initialState);

  increment() => emit(state + 1);
  decrement() => emit(state - 1);

  @override
  void onChange(Change<int> change) {
    super.onChange(change);

    print(change);
  }
}

// this is the event that the bloc emits
abstract class CounterEvent {}

// this is one of the implementation of that event
class CounterIncrementEvent extends CounterEvent {}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);

    print('${bloc.runtimeType} $event');
  }
}

// this is a bloc that will emit CounterEvent, and it have
// the value of an integer
// suspect that we will call the emit to counterevent directly
class IncrementBloc extends Bloc<CounterEvent, int> {
  IncrementBloc() : super(0) {
    on<CounterIncrementEvent>((event, emit) {
      addError(Exception("Increment Event"));
      emit(state + 1);
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print("Ada error $error $stackTrace");
  }

  @override
  void onEvent(CounterEvent event) {
    super.onEvent(event);

    print(event);
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);

    print(transition);
  }

  // @override
  // void onChange(Change<int> change) {
  //   super.onChange(change);

  //   print(change.nextState);
  // }
}

void main() {
  setupObserver();

  blocIncSubscribe();
}

void setupObserver() {
  SimpleBlocObserver observer = SimpleBlocObserver();
  Bloc.observer = observer;
}

void blocIncSubscribe() {
  final blocInc = IncrementBloc();
  blocInc.stream.listen((event) {
    print(event);
  });

  blocInc.add(CounterIncrementEvent());
  blocInc.add(CounterIncrementEvent());
  blocInc.add(CounterIncrementEvent());
  blocInc.add(CounterIncrementEvent());
}

void blocIncrementTest() {
  final blocInc = IncrementBloc();
  print(blocInc.state);
  blocInc.add(CounterIncrementEvent());
  blocInc.close();
}

void cubitOnChangeDefault() {
  final cubit = CubitOnChange(5);
  cubit.increment();
  cubit.decrement();
  cubit.increment();
  cubit.close();
}

void cubitListenToEvent() {
  final cubit = CounterCubit();
  cubit.stream.listen((event) {
    print(event);
  });
  cubit.increment();
  cubit.increment();
  cubit.increment();
  cubit.close();
}
