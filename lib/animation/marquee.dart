import 'package:flutter/material.dart';

/// This widget will animate the [child] for [animationDuration],
/// swap to [staticWidget] for [pauseDuration] then animate the [child] again
/// for [repeatCount] number of times
class MarqueeWidget extends StatefulWidget {
  final Widget child;
  final Widget staticWidget;
  final Axis direction;
  final Duration animationDuration, pauseDuration, initialDelay;
  final int repeatCount;

  const MarqueeWidget({
    Key? key,
    required this.child,
    required this.staticWidget,
    this.repeatCount = 3,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(milliseconds: 6000),
    this.initialDelay = const Duration(milliseconds: 500),
    this.pauseDuration = const Duration(milliseconds: 800),
  })  : assert(repeatCount > 0),
        super(key: key);

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  late ScrollController scrollController;
  int currentRepeat = 1;
  late Widget _currentWidget;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _currentWidget = _scrollingWidget;
    WidgetsBinding.instance.addPostFrameCallback((_) => scroll());
  }

  get _scrollingWidget => SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: widget.direction,
        controller: scrollController,
        child: widget.child,
      );

  get _staticWidget => widget.staticWidget;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _currentWidget;
  }

  void scroll() async {
    await Future.delayed(widget.initialDelay);

    if (scrollController.hasClients) {
      await scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: widget.animationDuration,
        curve: Curves.linear,
      );
    }

    setState(() {
      _currentWidget = _staticWidget;
    });

    await Future.delayed(widget.pauseDuration);

    if (currentRepeat < widget.repeatCount) {
      setState(() {
        currentRepeat += 1;
        _currentWidget = _scrollingWidget;
      });

      scroll();
    }
  }
}

class MarqueePage extends StatelessWidget {
  const MarqueePage({super.key});

  final double widgetSize = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: widgetSize,
          child: MarqueeWidget(
            direction: Axis.horizontal,
            repeatCount: 3,
            staticWidget: Container(
              alignment: Alignment.center,
              width: widgetSize,
              child: const Icon(Icons.abc),
            ),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: widgetSize,
                  child: const Icon(Icons.abc),
                ),
                const Text("This text is to long to be shown in just one line"),
                Container(
                  alignment: Alignment.center,
                  width: widgetSize,
                  child: const Icon(Icons.abc),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
