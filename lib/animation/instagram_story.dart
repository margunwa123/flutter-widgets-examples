import 'package:flutter/material.dart';

class InstagramStoryPage extends StatelessWidget {
  const InstagramStoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, index) {
        return Scaffold(
          body: Container(
            color: Colors.green,
            child: Text(index.toString()),
          ),
        );
      },
      itemCount: 2,
    );
    return const Scaffold(
      body: Center(
          // child: SizedBox(
          //   width: 200,
          //   child: _SliderWidget(
          //     widgets: [
          //       Container(
          //         color: Colors.blue,
          //         child: const Center(
          //           child: Text("Hi"),
          //         ),
          //       ),
          //       Container(
          //         color: Colors.red,
          //         child: const Center(
          //           child: Text("Bro"),
          //         ),
          //       ),
          //       Container(
          //         color: Colors.green,
          //         child: const Center(
          //           child: Text("tunak"),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}

class _SliderWidget extends StatefulWidget {
  const _SliderWidget({
    required this.widgets,
    // ignore: unused_element
    this.animationDuration = const Duration(milliseconds: 10),
    // ignore: unused_element
    this.pauseDuration = const Duration(milliseconds: 2500),
    // ignore: unused_element
    this.initialDelay = const Duration(milliseconds: 2500),
  });

  final List<Widget> widgets;
  final Duration pauseDuration;
  final Duration initialDelay;
  final Duration animationDuration;

  @override
  State<_SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<_SliderWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<Offset> _slideOutAnimation;
  late Animation<Offset> _slideInAnimation;
  late Animation<double> _fadeOutAnimation;
  late final screenWidth = MediaQuery.of(context).size.width;
  late final halfScreenWidth = MediaQuery.of(context).size.width / 2;

  int currentIndex = 0;
  double startDx = 0;

  get _currentWidget => widget.widgets[currentIndex];
  get _nextWidget => widget.widgets[
      currentIndex + 1 >= widget.widgets.length ? 0 : currentIndex + 1];

  double getSliderValue(double dx) => dx / screenWidth;

  animateForward() async {
    await _animationController.forward();

    advanceIndex();

    animateForward();
  }

  advanceIndex() {
    setState(() {
      if (currentIndex + 1 >= widget.widgets.length) {
        currentIndex = 0;
      } else {
        currentIndex += 1;
      }
      _animationController.reset();
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _slideOutAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-1, 0),
    ).animate(_animationController);

    _slideInAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 0),
    ).animate(_animationController);

    _fadeOutAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_animationController);

    // startAnimating();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: GestureDetector(
        onPanDown: (details) {
          setState(() {
            startDx = details.globalPosition.dx;
          });
        },
        onPanEnd: (details) {
          setState(() {
            startDx = 0;
          });
        },
        onPanUpdate: (details) {
          print("MARIO TUNAK TUN");
          print(getSliderValue(startDx - details.globalPosition.dx));
          _animationController
              .animateTo(getSliderValue(startDx - details.globalPosition.dx));
        },
        child: Stack(
          children: [
            SlideTransition(
              position: _slideOutAnimation,
              child: FadeTransition(
                opacity: _fadeOutAnimation,
                child: Container(
                  width: double.infinity,
                  color: Colors.green,
                  child: _currentWidget,
                ),
              ),
            ),
            SlideTransition(
              position: _slideInAnimation,
              child: Container(
                width: double.infinity,
                color: Colors.green,
                child: _nextWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startAnimating() async {
    await Future.delayed(widget.initialDelay);
    animateForward();
  }
}
