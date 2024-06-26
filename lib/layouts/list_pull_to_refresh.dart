import 'package:flutter/material.dart';

class ListPullToRefreshPage extends StatelessWidget {
  const ListPullToRefreshPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PullToRefreshWidget(),
    );
  }
}

class PullToRefreshWidget extends StatefulWidget {
  const PullToRefreshWidget({
    super.key,
  });

  @override
  State<PullToRefreshWidget> createState() => _PullToRefreshWidgetState();
}

class _PullToRefreshWidgetState extends State<PullToRefreshWidget>
    with TickerProviderStateMixin {
  final _scrollController = ScrollController();
  late final AnimationController _scaleController;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
    );

    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      if (offset > 0) return;

      _scaleController.value = -offset / 100.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          child: Column(
            children: [
              Container(
                height: 400,
                color: Colors.green,
                width: double.infinity,
              ),
              Container(
                height: 400,
                color: Colors.red,
                width: double.infinity,
              ),
              Container(
                height: 400,
                color: Colors.yellow,
                width: double.infinity,
              ),
              Container(
                height: 400,
                color: Colors.blue,
                width: double.infinity,
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: FadeTransition(
            opacity: _scaleController,
            child: ScaleTransition(
              alignment: Alignment.topCenter,
              scale: _scaleController,
              child: Container(
                alignment: Alignment.center,
                color: Colors.blueAccent,
                width: 100,
                child: const Text("TUNAK TUNAK  TUN"),
              ),
            ),
          ),
        )
      ],
    );
  }
}
