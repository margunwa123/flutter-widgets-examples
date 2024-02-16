import 'package:flutter/material.dart';
import 'package:page_route_animation/animation/sliding_widget.dart';
import 'package:page_route_animation/others/banner_gojek/banner_list_widget.dart';
import 'package:page_route_animation/others/scanner_nudge_doubts/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPref = await SharedPreferences.getInstance();
  if (sharedPref.getInt(chosenOne) == null) {
    sharedPref.setInt(chosenOne, 2);
    sharedPref.setInt(notChosenOne, 30);
  }

  runApp(const MaterialApp(
    home: PeriodicSlidingPage(),
  ));
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  final secondKey = GlobalKey();
  final thirdKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);

    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        children: const [
          BannerListWidget(),
        ],
      ),
    );
  }
}
