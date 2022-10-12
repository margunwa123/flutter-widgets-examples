import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RippleTwoApp extends StatefulWidget {
  const RippleTwoApp({super.key});

  @override
  State<RippleTwoApp> createState() => _RippleTwoAppState();
}

class _RippleTwoAppState extends State<RippleTwoApp> {
  final _firstKey = GlobalKey();
  Rect? _firstContainerRect;
  Rect? _firstRippleRect;
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: const Text("Having fun with rippling")),
          body: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1,
            padding: EdgeInsets.all(10),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              GestureDetector(
                key: _firstKey,
                onTap: _playRippleAnimation,
                child: Container(
                  color: Colors.red,
                )
              ),
            ],
          ),
        ),

         _firstRippleAnimator,
      ],
    );
  }

  void _playRippleAnimation() {
    setState(() {
      _firstContainerRect = _getWidgetRect(_firstKey);
      _firstRippleRect = _firstContainerRect;
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final fullScreenSize = 1.3 * MediaQuery.of(context).size.longestSide;
      
      setState(() {
        _firstRippleRect = _firstRippleRect?.inflate(fullScreenSize);
      });
    });
  }

  Rect? _getWidgetRect(GlobalKey key) {
    final renderObj = key.currentContext!.findRenderObject();
    final position = renderObj?.getTransformTo(null).getTranslation();
    final size = renderObj?.semanticBounds.size;

    if(position == null || size == null) return null;

    return Rect.fromLTWH(
      position.x, 
      position.y, 
      size.width, 
      size.height
    );
  }

  Widget get _firstRippleAnimator {
    if(_firstRippleRect == null) {
      print("ITS RAW");
      return Container(
        width: 0,
        height: 0,
      );
    }
    
    return AnimatedPositioned.fromRect(
      rect: _firstRippleRect!,
      duration: const Duration(milliseconds: 200),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.red
        ),
      ),
      onEnd: () {
        final expanded = _firstRippleRect != _firstContainerRect;

        if(expanded) {
          // shrink the container again
          setState(() {
            _firstRippleRect = _firstContainerRect;
          });
        }
        else {
          setState(() {
            _firstRippleRect = null;
          });
        }
      },
    );
  }
}