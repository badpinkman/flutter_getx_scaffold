import 'package:flutter/material.dart';

import '../01_shine_static/circle_shine_image.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Wrap(
        spacing: 50,
        children: [
          CircleShineImage(
            image: AssetImage('assets/images/icon_head.png'),
            color: Colors.blue,
            maxBlurRadius: 4,
            curve: Curves.decelerate,
          ),
          CircleShineImage(
            image: AssetImage('assets/images/icon_8.jpg'),
            color: Colors.red,
            maxBlurRadius: 6,
            duration: Duration(seconds: 1),
            curve: Curves.easeIn,
          ),
          CircleShineImage(
            image: AssetImage('assets/images/wy_300x200.jpg'),
            color: Colors.purple,
            maxBlurRadius: 8,
            curve: Curves.ease,
          ),
        ],
      ),
    );
  }
}
