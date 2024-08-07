import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:page_route_animation/utils/hextocolor.dart';

class AnimationUpAndDownApp extends StatefulWidget {
  const AnimationUpAndDownApp({super.key, required this.shrinkingStartHeight});

  final double shrinkingStartHeight;

  @override
  State<AnimationUpAndDownApp> createState() => _AnimationUpAndDownState();
}

const containerHeight = 360.0;
const containerWidth = 253.0;
const double yellowScannerHeight = 100;
const shrinkDuration = Duration(milliseconds: 700);
const bounceDuration = Duration(milliseconds: 2000);

class _AnimationUpAndDownState extends State<AnimationUpAndDownApp>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: shrinkDuration,
    );
    _backgroundAnimation =
        ColorTween(begin: Colors.black, end: "#00AED6".hexToColor()).animate(
      _controller,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height:
                (MediaQuery.of(context).size.height + containerHeight) / 2 + 16,
          ),
          const Text(
            "Scanning",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: 253,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ],
      ),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _backgroundAnimation.value,
          body: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (_controller.isAnimating || _controller.isCompleted)
                  child ?? const SizedBox.shrink(),
                Stack(
                  children: [
                    FutureBuilder<double>(
                      future: heightPerWidthAspectRatio(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return _ShrinkAnimationWidget(
                            heightPerWidthAspectRatio: snapshot.data!,
                            screenSize: MediaQuery.of(context).size,
                            animationController: _controller,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    if (_controller.isCompleted) const _BounceAnimationWidget(),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<double> heightPerWidthAspectRatio() async {
    return containerHeight / containerWidth;
  }
}

class _ShrinkAnimationWidget extends StatefulWidget {
  const _ShrinkAnimationWidget({
    required this.heightPerWidthAspectRatio,
    required this.screenSize,
    required this.animationController,
  });
  final Size screenSize;
  final double heightPerWidthAspectRatio;
  final AnimationController animationController;

  @override
  State<_ShrinkAnimationWidget> createState() => __ShrinkAnimationWidgetState();
}

class __ShrinkAnimationWidgetState extends State<_ShrinkAnimationWidget>
    with TickerProviderStateMixin {
  late final Animation<Decoration> decorationTween;

  late final Animation<double> widthAnimation;
  late final Animation<double> heightAnimation;

  @override
  void initState() {
    super.initState();
    decorationTween = DecorationTween(
      begin: BoxDecoration(
        color: Colors.white,
        border: Border.all(style: BorderStyle.none),
        borderRadius: BorderRadius.circular(0),
      ),
      end: BoxDecoration(
        color: Colors.white,
        border: Border.all(style: BorderStyle.solid, color: Colors.white),
        borderRadius: BorderRadius.circular(16),
      ),
    ).animate(widget.animationController);

    widthAnimation = Tween<double>(
      begin: widget.screenSize.width,
      end: containerWidth,
    ).animate(widget.animationController);

    heightAnimation = Tween<double>(
      begin: widget.screenSize.width * widget.heightPerWidthAspectRatio,
      end: containerHeight,
    ).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.animationController,
        child: Image.asset(
          'assets/bill.jpeg',
          width: containerWidth,
          height: containerHeight,
          fit: BoxFit.cover,
        ),
        builder: (context, child) {
          return Container(
            width: widthAnimation.value,
            height: heightAnimation.value,
            decoration: decorationTween.value,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: child,
            ),
          );
        });
  }
}

class _BounceAnimationWidget extends StatefulWidget {
  const _BounceAnimationWidget();

  @override
  State<_BounceAnimationWidget> createState() => __BounceAnimationWidgetState();
}

class __BounceAnimationWidgetState extends State<_BounceAnimationWidget> {
  _animate() {
    setState(() {
      _isForward = !_isForward;
    });
  }

  bool _isForward = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: containerWidth,
      height: containerHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: bounceDuration,
              // curve: Curves.linear,
              curve: Curves.easeInOut,
              // top: _isForward ? containerHeight - yellowScannerHeight : 0,
              top: _isForward
                  ? containerHeight - yellowScannerHeight / 2
                  : -yellowScannerHeight / 2,
              onEnd: () => _animate(),
              left: 0,
              right: 0,
              child: SizedBox(
                width: double.infinity,
                height: yellowScannerHeight * 2,
                child: Column(
                  children: [
                    Transform.rotate(
                      angle: math.pi,
                      child: SizedBox(
                        height: yellowScannerHeight,
                        width: double.infinity,
                        child: imageAsset,
                      ),
                    ),
                    SizedBox(
                        height: yellowScannerHeight,
                        width: double.infinity,
                        child: imageAsset),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  get imageAsset => ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(200, 227, 204, 204),
              Color.fromARGB(0, 227, 204, 204),
            ],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: Image.asset(
          'assets/line.png',
          height: yellowScannerHeight,
          repeat: ImageRepeat.repeatX,
        ),
      );
}
