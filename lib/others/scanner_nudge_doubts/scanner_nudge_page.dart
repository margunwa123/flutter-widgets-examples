import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_route_animation/others/scanner_nudge_doubts/config.dart';
import 'package:page_route_animation/others/scanner_nudge_doubts/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScannerNudgePage extends StatefulWidget {
  const ScannerNudgePage({super.key});

  @override
  State<ScannerNudgePage> createState() => _ScannerNudgePageState();
}

class _ScannerNudgePageState extends State<ScannerNudgePage> {
  String? title;
  String? subtitle;
  String? text;

  @override
  void initState() {
    super.initState();

    initiateItems();
  }

  AssetBundle getAssetBundle() {
    return DefaultAssetBundle.of(context);
  }

  initiateItems() async {
    final data =
        await getAssetBundle().loadString("assets/scanner_nudge_master.json");
    const decoder = JsonDecoder();
    final sharedPreferences = await SharedPreferences.getInstance();

    final masterConfig = decoder.convert(data);
    List<String> configurationPriorities =
        (masterConfig["configurations"] as List<dynamic>)
            .map((e) => e.toString())
            .toList();
    int i = 0;
    while (i < configurationPriorities.length) {
      String configName = configurationPriorities[i];
      final fileName = getFileNameFromConfig(configName);

      final configString = await getAssetBundle().loadString(fileName);
      final config = Config.fromJson(configString);
      final numOfViews = getNumOfViewsFromConfig(configName, sharedPreferences);
      if (numOfViews >= config.limit) {
        i++;
        continue;
      } else {
        print(i);
        setState(() {
          title = config.title;
          subtitle = config.subtitle;
          text = config.text;
        });
        return;
      }
    }

    print("INITIATE FAILED");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            subtitle ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
          ),
          Text(text ?? ""),
        ],
      ),
    );
  }

  int getNumOfViewsFromConfig(
      String configName, SharedPreferences sharedPreferences) {
    if (configName == chosenOne) {
      return sharedPreferences.getInt(chosenOne) ?? 0;
    }
    return sharedPreferences.getInt(notChosenOne) ?? 10;
  }

  String getFileNameFromConfig(String configName) {
    if (configName == chosenOne) {
      return "assets/configs/scanner_nudge_chosen_one.json";
    }
    return "assets/configs/scanner_nudge_fake.json";
  }
}
