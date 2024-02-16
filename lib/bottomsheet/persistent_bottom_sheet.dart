import 'package:flutter/material.dart';
import 'package:page_route_animation/bottomsheet/notch_card_widget.dart';

class PersistentBottomSheetScreen extends StatefulWidget {
  const PersistentBottomSheetScreen({super.key});

  @override
  State<PersistentBottomSheetScreen> createState() =>
      _PersistentBottomSheetScreenState();
}

class _PersistentBottomSheetScreenState
    extends State<PersistentBottomSheetScreen> {
  double sheetBlackenPercentage = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Persistent Bottom Sheet"),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.green[100],
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                ElevatedButton(onPressed: () {}, child: const Text("TUnak tun"))
              ],
            ),
          ),
          if (sheetBlackenPercentage >= 0.05)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5 * sheetBlackenPercentage),
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          BottomDetailsSheet(
            onBottomSheetExpanded: (expandedPercentage) {
              if (expandedPercentage >= 0.99) {
                setState(() {
                  sheetBlackenPercentage = 1;
                });
              } else if (expandedPercentage <= 0.01) {
                setState(() {
                  sheetBlackenPercentage = 0.0;
                });
              } else {
                setState(() {
                  sheetBlackenPercentage = expandedPercentage;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

class BottomDetailsSheet extends StatefulWidget {
  const BottomDetailsSheet({
    super.key,
    this.onBottomSheetExpanded,
  });

  static const initialHeight = 256.0;

  final void Function(double expandedPercentage)? onBottomSheetExpanded;

  @override
  State<BottomDetailsSheet> createState() => _BottomDetailsSheetState();
}

class _BottomDetailsSheetState extends State<BottomDetailsSheet> {
  final controller = DraggableScrollableController();

  get maxExtent => 0.8;
  get minExtent => getPixelAsPercentage();
  get extentRange => maxExtent - minExtent;

  double getPixelAsPercentage() {
    final height = MediaQuery.of(context).size.height;
    final percentage = BottomDetailsSheet.initialHeight / height;
    return percentage;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          bottom: BottomDetailsSheet.initialHeight,
          left: 0,
          child: Center(child: Text("this is the badge")),
        ),
        NotificationListener<DraggableScrollableNotification>(
          onNotification: (notif) {
            widget.onBottomSheetExpanded
                ?.call((notif.extent - minExtent) / extentRange);
            return true;
          },
          child: DraggableScrollableSheet(
            initialChildSize: minExtent,
            minChildSize: minExtent,
            maxChildSize: maxExtent,
            controller: controller,
            snap: true,
            builder: (BuildContext context, ScrollController scrollController) {
              print("WOO HOO");
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  color: Colors.white,
                ),
                child: ListView(
                  controller: scrollController,
                  children: const [
                    SizedBox(
                      height: 8,
                    ),
                    NotchCardLineWidget(),
                    SizedBox(
                      height: 16,
                    ),
                    // Fill the content....
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
