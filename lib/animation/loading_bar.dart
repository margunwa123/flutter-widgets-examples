import 'package:flutter/material.dart';

enum LoadingStatus {
  idle,
  uploading,
  scanning,
  completed,
}

// placeholder widget
class LoadingBarPage extends StatefulWidget {
  const LoadingBarPage({super.key});

  @override
  State<LoadingBarPage> createState() => _LoadingBarPageState();
}

class _LoadingBarPageState extends State<LoadingBarPage> {
  LoadingStatus status = LoadingStatus.idle;

  @override
  void initState() {
    super.initState();
    _progressUpload();
  }

  Future<void> _progressUpload() async {
    await _progressTo(
        LoadingStatus.uploading, const Duration(milliseconds: 100));
    await _progressTo(
      LoadingStatus.scanning,
      const Duration(milliseconds: 1000),
    );
    await _progressTo(
      LoadingStatus.completed,
      const Duration(milliseconds: 2000),
    );
  }

  Future<void> _progressTo(LoadingStatus status, Duration duration) async {
    await Future.delayed(duration);
    setState(() {
      this.status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingBar(
      status: status,
      onCompleted: () {},
    );
  }
}

class LoadingBar extends StatelessWidget {
  const LoadingBar({
    super.key,
    required this.status,
    required this.onCompleted,
  });

  final LoadingStatus status;
  final void Function() onCompleted;

  double get _progress {
    switch (status) {
      case LoadingStatus.completed:
        return 1;
      case LoadingStatus.idle:
        return 0;
      case LoadingStatus.scanning:
        return 0.90;
      case LoadingStatus.uploading:
        return 0.25;
    }
  }

  Duration get _animationDuration {
    switch (status) {
      case LoadingStatus.completed:
        return const Duration(seconds: 1);
      case LoadingStatus.idle:
        return Duration.zero;
      case LoadingStatus.scanning:
        return const Duration(seconds: 3);
      case LoadingStatus.uploading:
        return const Duration(seconds: 1);
    }
  }

  String get _textState {
    switch (status) {
      case LoadingStatus.completed:
        return "Completed";
      case LoadingStatus.idle:
        return "";
      case LoadingStatus.scanning:
        return "Scanning";
      case LoadingStatus.uploading:
        return "Uploading";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 174, 214, 1),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TextStateWidget(textState: _textState),
            const SizedBox(
              height: 12,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              height: 16,
              width: 253,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: _LoadingBarBuilder(
                percentage: _progress,
                maxWidth: 237,
                animationDuration: _animationDuration,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextStateWidget extends StatelessWidget {
  const _TextStateWidget({
    required this.textState,
  });

  final String textState;

  @override
  Widget build(BuildContext context) {
    return Text(textState);
  }
}

class _LoadingBarBuilder extends StatelessWidget {
  const _LoadingBarBuilder({
    required this.percentage,
    required this.maxWidth,
    required this.animationDuration,
  });

  final double percentage;
  final double maxWidth;
  final Duration animationDuration;

  double get _width => percentage * maxWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          height: 8,
          width: _width,
          curve: Curves.easeOut,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          duration: animationDuration,
        ),
      ],
    );
  }
}
