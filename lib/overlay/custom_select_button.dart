import 'package:flutter/material.dart';

class CustomSelectButtonApp extends StatelessWidget {
  const CustomSelectButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CompositeTransformTargetApp")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: SizedBox(
              child: CustomSelectButton(),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSelectButton extends StatefulWidget {
  const CustomSelectButton({
    super.key,
    this.items = const ["One", "Two", "Three", "Four", "Five"],
  });

  final List<String> items;

  @override
  State<CustomSelectButton> createState() => _CustomSelectButtonState();
}

class _CustomSelectButtonState extends State<CustomSelectButton> {
  static double itemHeight = 100;
  static double selectorHeight = 40;

  bool isOpened = false;

  final layerLink = LayerLink();

  late OverlayEntry? overlayEntry;

  void showIndicator() {
    if (isOpened) {
      return hideIndicator();
    }

    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: 0,
        top: 0,
        child: SizedBox(
          width: size.width,
          height: itemHeight,
          child: CompositedTransformFollower(
            link: layerLink,
            offset: Offset(0, selectorHeight),
            child: Container(
              color: Colors.teal[400],
              child: Text("${size.width}"),
            ),
          ),
        ),
      );
    });
    Overlay.of(context)?.insert(overlayEntry!);
    setState(() {
      isOpened = true;
    });
  }

  void hideIndicator() {
    overlayEntry?.remove();
    setState(() {
      isOpened = false;
    });
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: GestureDetector(
        child: const Text("Hello world"),
        onTapDown: (details) {
          showIndicator();
        },
      ),
    );
  }
}
