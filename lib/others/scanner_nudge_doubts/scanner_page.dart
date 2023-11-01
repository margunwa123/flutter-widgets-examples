import 'package:flutter/material.dart';
import 'package:page_route_animation/others/scanner_nudge_doubts/scanner_nudge_page.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ScannerNudgePage()));
            },
            child: const Text("Go to the screen"),
          )
        ],
      ),
    );
  }
}
