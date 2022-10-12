import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RippleFirstPage extends StatefulWidget {
  const RippleFirstPage({super.key});

  @override
  State<RippleFirstPage> createState() => _RippleFirstPageState();
}

class _RippleFirstPageState extends State<RippleFirstPage> {
  final _rippleKey = GlobalKey();
  final _fabColor = Colors.blue;
  Rect? _pageTransitionRect;
  Rect? _fabButtonRect;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Center(child: Text("Ripple Navigation")),
          floatingActionButton: FloatingActionButton(
            backgroundColor: _fabColor,
            key: _rippleKey,
            onPressed: () {
              _playRippleTransition();
            },
            child: Icon(Icons.add),
          ),
        ),
        _pageTransition
      ],
    );
  }

  void _playRippleTransition() {
    setState(() {
      _fabButtonRect = _getWidgetRect(_rippleKey)!;
      _pageTransitionRect = _fabButtonRect;
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final fullScreenSize = 1.3 * MediaQuery.of(context).size.longestSide;

      setState(() {
        _pageTransitionRect = _pageTransitionRect?.inflate(fullScreenSize);
      });
    });
  }

  Widget get _pageTransition {
    if (_pageTransitionRect == null) {
      return Container();
    }

    return AnimatedPositioned.fromRect(
      rect: _pageTransitionRect!,
      duration: const Duration(milliseconds: 300),
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: _fabColor),
      ),
      onEnd: () {
        bool shouldNavigate = _pageTransitionRect != _fabButtonRect;

        if (shouldNavigate) {
          Navigator.push(
                  context, FadeRouteBuilder(page: const RippleSecondPage()))
              .then((value) {
            setState(() {
              // shrink back to normal fab button size
              _pageTransitionRect = _fabButtonRect;
            });
          });
        } else {
          setState(() {
            _pageTransitionRect = null;
          });
        }
      },
    );
  }

  Rect? _getWidgetRect(GlobalKey key) {
    final renderObj = key.currentContext?.findRenderObject();
    final translation = renderObj?.getTransformTo(null).getTranslation();
    final size = renderObj?.semanticBounds.size;

    if (translation != null && size != null) {
      return new Rect.fromLTWH(
          translation.x, translation.y, size.width, size.height);
    } else {
      return null;
    }
  }
}

class RippleSecondPage extends StatelessWidget {
  const RippleSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("An appbar"),
      ),
      body: Center(
        child: Text("Page two"),
      ),
    );
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  FadeRouteBuilder({required Widget page})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: Duration(milliseconds: 300),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child));
}
