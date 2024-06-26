import 'package:flutter/material.dart';

enum SplitBillStatus {
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
  SplitBillStatus status = SplitBillStatus.idle;

  @override
  void initState() {
    super.initState();
    _progressUpload();
  }

  Future<void> _progressUpload() async {
    await _progressTo(
        SplitBillStatus.uploading, const Duration(milliseconds: 100));
    await _progressTo(
      SplitBillStatus.scanning,
      const Duration(milliseconds: 1000),
    );
    await _progressTo(
      SplitBillStatus.completed,
      const Duration(milliseconds: 2000),
    );
  }

  Future<void> _progressTo(SplitBillStatus status, Duration duration) async {
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

  final SplitBillStatus status;
  final void Function() onCompleted;

  double get _progress {
    switch (status) {
      case SplitBillStatus.completed:
        return 1;
      case SplitBillStatus.idle:
        return 0;
      case SplitBillStatus.scanning:
        return 0.90;
      case SplitBillStatus.uploading:
        return 0.25;
    }
  }

  Duration get _animationDuration {
    switch (status) {
      case SplitBillStatus.completed:
        return const Duration(seconds: 1);
      case SplitBillStatus.idle:
        return Duration.zero;
      case SplitBillStatus.scanning:
        return const Duration(seconds: 3);
      case SplitBillStatus.uploading:
        return const Duration(seconds: 1);
    }
  }

  String get _textState {
    switch (status) {
      case SplitBillStatus.completed:
        return "Completed";
      case SplitBillStatus.idle:
        return "";
      case SplitBillStatus.scanning:
        return "Scanning";
      case SplitBillStatus.uploading:
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
