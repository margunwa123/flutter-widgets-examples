import 'package:flutter/material.dart';

class PeriodicSlidingPage extends StatelessWidget {
  const PeriodicSlidingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          child: _PeriodicSlidingWidgets(
            widgets: [
              Text("Hi"),
              Text("hello"),
              Text("data"),
            ],
          ),
        ),
      ),
    );
  }
}

class _PeriodicSlidingWidgets extends StatefulWidget {
  const _PeriodicSlidingWidgets({
    required this.widgets,
    // ignore: unused_element
    this.animationDuration = const Duration(milliseconds: 500),
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
  State<_PeriodicSlidingWidgets> createState() =>
      __PeriodicSlidingWidgetsState();
}

class __PeriodicSlidingWidgetsState extends State<_PeriodicSlidingWidgets>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<Offset> _slideOutAnimation;
  late Animation<Offset> _slideInAnimation;
  int currentIndex = 0;
  late Animation<double> _fadeOutAnimation;

  get _currentWidget => widget.widgets[currentIndex];
  get _nextWidget => widget.widgets[
      currentIndex + 1 >= widget.widgets.length ? 0 : currentIndex + 1];

  animateForward() async {
    await _animationController.forward();

    advanceIndex();

    await takePause();

    animateForward();
  }

  Future<void> takePause() {
    return Future.delayed(widget.pauseDuration);
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
      end: const Offset(-1.1, 0),
    ).animate(_animationController);

    _slideInAnimation = Tween<Offset>(
      begin: const Offset(1.1, 0),
      end: const Offset(0, 0),
    ).animate(_animationController);

    _fadeOutAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_animationController);

    startAnimating();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
    );
  }

  void startAnimating() async {
    await Future.delayed(widget.initialDelay);
    animateForward();
  }
}
