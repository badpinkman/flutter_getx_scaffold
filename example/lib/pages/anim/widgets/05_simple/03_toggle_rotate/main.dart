import 'package:example/pages/anim/widgets/05_simple/03_toggle_rotate/toggle_rotate.dart';
import 'package:flutter/material.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 50,
        children: [
          ToggleRotate(
            beginAngle: 0,
            endAngle: 45,
            curve: Curves.decelerate,
            durationMs: 400,
            clockwise: true,
            child: const Icon(
              Icons.forward,
              size: 60,
              color: Colors.orangeAccent,
            ),
            onEnd: (v) {
              print("---expanded---:$v-------");
            },
          ),
          ToggleRotate(
            beginAngle: -30,
            endAngle: 45,
            curve: Curves.ease,
            child: const Image(
                width: 60,
                height: 60,
                image: AssetImage("assets/images/icon_head.png")),
            onEnd: (v) {
              print("---expanded---:$v-------");
            },
            onTap: () {
              print("---tap----------");
            },
          ),
          ToggleRotate(
            beginAngle: 180,
            endAngle: 180 + 45.0,
            curve: Curves.decelerate,
            durationMs: 400,
            clockwise: false,
            child: const Icon(
              Icons.forward,
              size: 60,
              color: Colors.orangeAccent,
            ),
            onEnd: (v) {
              print("---expanded---:$v-------");
            },
          ),
        ],
      ),
    );
  }
}
