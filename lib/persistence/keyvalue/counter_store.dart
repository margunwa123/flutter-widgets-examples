import 'package:shared_preferences/shared_preferences.dart';

const COUNTER_NAME = "counter";

class CounterKeyValue {
  final _prefs = SharedPreferences.getInstance();
  
  Future<void> saveCounter(int counter) async {
    (await _prefs).setInt(COUNTER_NAME, counter);
  }

  Future<int> getCounter() async {
    return (await _prefs).getInt(COUNTER_NAME) ?? 0;
  }
}