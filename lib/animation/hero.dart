import 'package:flutter/material.dart';

class AnimateAcrossScreen extends StatelessWidget {
  const AnimateAcrossScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Screen")
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const DetailScreen();
          }));
        },
        child: Hero( tag: 'imageHero', child: Image.network('https://picsum.photos/250?image=9'))
      )
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const AnimateAcrossScreen();
          }));
        },
        child: Center(
          child: Hero(tag: 'imageHero', child: Image.network('https://picsum.photos/250?image=9')),
        ),
      )
    );
  }
}
