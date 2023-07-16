import 'package:flutter/material.dart';
import 'package:page_route_animation/overlay/composite_transform_target_app.dart';

void main() {
  runApp(const MaterialApp(
    home: CompositeTransformTargetApp(),
  ));
}

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("asds"),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () => Navigator.of(context).push(_createRoute()),
        child: const Text("Go"),
      )),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const PageTwo(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeOut;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation =
            CurvedAnimation(parent: animation, curve: curve);

        return SlideTransition(
            position: tween.animate(curvedAnimation), child: child);
      });
}

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Duar pagetwo")),
        body: const Center(child: Text("Hello from pagetwo")));
  }
}
