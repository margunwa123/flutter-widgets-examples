import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  bool draggable = false;
  bool dismissable = false;
  bool scrollControlled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: draggable,
                onChanged: (value) {
                  setState(() {
                    draggable = value ?? !draggable;
                  });
                },
              ),
              const Text("Draggable")
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: dismissable,
                onChanged: (value) {
                  setState(() {
                    dismissable = value ?? !dismissable;
                  });
                },
              ),
              const Text("Dismissable")
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: scrollControlled,
                onChanged: (value) {
                  setState(() {
                    scrollControlled = value ?? !scrollControlled;
                  });
                },
              ),
              const Text("scrollControlled")
            ],
          ),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isDismissible: dismissable,
                isScrollControlled: scrollControlled,
                enableDrag: draggable,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: const Text("HAHAHAHAH"),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text("Tunak Bros"),
          ),
        ],
      ),
    );
  }
}
