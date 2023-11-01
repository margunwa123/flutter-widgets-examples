// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_element
import 'package:flutter/material.dart';

class BannerListWidget extends StatelessWidget {
  const BannerListWidget({
    super.key,
    this.backgroundColor = Colors.transparent,
  });

  static const paddingBetweenCard = 4.0;
  static const cardItems = ["xd", "haha"];

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 8,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  "https://images.unsplash.com/photo-1611003228941-98852ba62227?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmFieSUyMGRvZ3xlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80",
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
                Stack(
                  children: [
                    ...buildBundleCardWidgets(),
                  ],
                ),
              ],
            ),
            const Positioned(
              left: 0,
              top: 0,
              child: _RoundedIconButton(
                icon: Icons.close,
              ),
            ),
            const Positioned(
                right: 0,
                top: 0,
                child: _RoundedIconButton(
                  icon: Icons.share,
                ))
          ],
        ),
      ),
    );
  }

  List<Widget> buildBundleCardWidgets() {
    final List<Widget> widgets = [];
    for (var i = 0; i < cardItems.length; i++) {
      final topPosition =
          i * (_BundleCardWidget.mainHeight + paddingBetweenCard);

      if (i == 0) {
        widgets.add(
          _BundleCardWidget(
            height: getCardsContainerHeight(),
            cta: CtaModel(title: "Buy now", deeplink: null),
            imageUrl: "",
            title: "Qris Unlimited",
          ),
        );
      } else {
        widgets.add(
          Positioned(
            top: topPosition,
            left: 0,
            right: 0,
            child: _BundleCardWidget(
              height: i == (cardItems.length - 1)
                  ? _BundleCardWidget.mainHeight
                  : _BundleCardWidget.heightWithBuffer,
              cta: CtaModel(
                title: "Buy now",
                deeplink: null,
              ),
              imageUrl: "",
              title: "Qris Unlimited+",
              description: "Cashback up to 80K",
            ),
          ),
        );
      }
    }
    return widgets;
  }

  double getCardsContainerHeight() {
    if (cardItems.isEmpty) return 0;

    return _BundleCardWidget.mainHeight +
        (cardItems.length - 1) *
            (paddingBetweenCard + _BundleCardWidget.mainHeight);
  }
}

class _RoundedIconButton extends StatelessWidget {
  const _RoundedIconButton({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.white, // Button color
        child: InkWell(
          splashColor: Colors.red, // Splash color
          onTap: () {},
          child: SizedBox(
            width: 40,
            height: 40,
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}

class _BundleCardWidget extends StatelessWidget {
  const _BundleCardWidget({
    Key? key,
    required this.height,
    required this.title,
    required this.imageUrl,
    required this.cta,
    this.description,
    this.onTap,
  }) : super(key: key);

  static const mainHeight = 78.0;
  static const heightWithBuffer = 118.0;
  static const imageSize = 32.0;

  final double height;
  final VoidCallback? onTap;
  final String title;
  final String? description;
  final String imageUrl;
  final CtaModel cta;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Color.fromARGB(38, 0, 0, 0),
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        height: height,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: mainHeight,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  imageUrl,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                      "https://images.unsplash.com/photo-1611003228941-98852ba62227?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmFieSUyMGRvZ3xlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80",
                    );
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      if (description != null && description!.isNotEmpty)
                        Text(description!),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    cta.deeplink;
                  },
                  child: Text(cta.title),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CtaModel {
  final String title;
  final String? deeplink;

  CtaModel({
    required this.title,
    this.deeplink,
  });
}
