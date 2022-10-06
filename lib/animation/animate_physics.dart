import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class PhysicsCardDragDemo extends StatelessWidget {
  const PhysicsCardDragDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PhysicsCardDragDemo")),
      body: const DraggableCard(child: FlutterLogo(
        size: 128,
      ))
    );
  }
}

class DraggableCard extends StatefulWidget {
  const DraggableCard({required this.child, super.key});

  final Widget child;

  @override
  State<DraggableCard> createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> 
  with SingleTickerProviderStateMixin {
  late AnimationController _backToCenterController;
  late Animation<Alignment> _backToCenterAnimation;
  Alignment _currentPosition = Alignment.center;

  @override
  void initState() {
    super.initState();
    _backToCenterController = 
      AnimationController(vsync: this, duration: const Duration(seconds: 1));
    
    // when it's animating, change the position of the
    // element to the animation value
    _backToCenterController.addListener(() {
      setState(() {
        _currentPosition = _backToCenterAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _backToCenterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var windowSize = MediaQuery.of(context).size;

    return GestureDetector(
      onPanDown: (details) {
        _backToCenterController.stop();
      },
      onPanUpdate: (details) {
        setState(() {
          _currentPosition += Alignment(
            // delta is the difference between the starting
            // drag position to the ending drag position
            details.delta.dx / (windowSize.width / 2),
            details.delta.dy / (windowSize.height / 2)
          );
        });
      },
      onPanEnd: (details) {
        _animateBackToCenter(details.velocity.pixelsPerSecond, windowSize);
      },
      child: Align(
        alignment: _currentPosition,
        child: Card(
          child: widget.child,
        )
      ),
    );
  }

  void _animateBackToCenter(Offset pixelsPerSecond, Size size) {
    _backToCenterAnimation = _backToCenterController.drive(
      AlignmentTween(
        begin: _currentPosition,
        end: Alignment.center
      )
    );

    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitsVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(mass: 30, stiffness: 1, damping: 1);

    final Simulation simulation = SpringSimulation(spring, 0, 1, -unitsVelocity);

    _backToCenterController.animateWith(simulation);
  }
}
