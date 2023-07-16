import 'package:flutter/material.dart';

class CompositeTransformTargetApp extends StatefulWidget {
  const CompositeTransformTargetApp({super.key});

  @override
  State<CompositeTransformTargetApp> createState() =>
      _CompositeTransformTargetAppState();
}

class _CompositeTransformTargetAppState
    extends State<CompositeTransformTargetApp> {
  static double indicatorWidth = 24;
  static double indicatorHeight = 300;
  static double slideHeight = 200;
  static double slideWidth = 400;

  final double y = (slideHeight - indicatorHeight) / 2;

  final layerLink = LayerLink();

  late OverlayEntry? overlayEntry;

  Offset indicatorOffset = Offset.zero;

  Offset getIndicatorOffset(Offset dragOffset) {
    final double x = (dragOffset.dx - (indicatorWidth / 2))
        .clamp(0.0, slideWidth - indicatorWidth);

    return Offset(x, y);
  }

  void showIndicator(DragStartDetails details) {
    indicatorOffset = getIndicatorOffset(details.localPosition);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: 0,
        top: 0,
        child: SizedBox(
          width: indicatorWidth,
          height: indicatorHeight,
          child: CompositedTransformFollower(
            link: layerLink,
            offset: indicatorOffset,
            child: Container(
              color: Colors.teal[400],
            ),
          ),
        ),
      );
    });
    Overlay.of(context)?.insert(overlayEntry!);
  }

  void updateIndicator(DragUpdateDetails details) {
    indicatorOffset = getIndicatorOffset(details.localPosition);
    overlayEntry?.markNeedsBuild();
  }

  void hideIndicator(DragEndDetails details) {
    overlayEntry?.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CompositeTransformTargetApp")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                showIndicator(DragStartDetails(
                  globalPosition: const Offset(0, 0),
                  localPosition: const Offset(0, 0),
                ));
              },
              child: const Text("show")),
          ElevatedButton(
              onPressed: () {
                hideIndicator(DragEndDetails(
                  primaryVelocity: 0,
                  velocity: const Velocity(
                    pixelsPerSecond: Offset(0, 0),
                  ),
                ));
              },
              child: const Text("hide")),
          Center(
            child: CompositedTransformTarget(
              link: layerLink,
              child: Container(
                width: slideWidth,
                height: slideHeight,
                color: Colors.cyan[100],
                child: GestureDetector(
                  onPanStart: showIndicator,
                  onPanUpdate: updateIndicator,
                  onPanEnd: hideIndicator,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
