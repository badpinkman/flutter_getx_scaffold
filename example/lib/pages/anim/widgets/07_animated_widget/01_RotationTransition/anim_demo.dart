import 'package:flutter/material.dart';

class AnimDemo extends StatefulWidget {
  const AnimDemo({super.key});

  @override
  State<AnimDemo> createState() => _AnimDemoState();
}

class _AnimDemoState extends State<AnimDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = CurveTween(curve: Curves.linear).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _ctrl.forward(from: 0),
      child: Container(
        color: Colors.grey.withAlpha(22),
        width: 100,
        height: 100,
        child: RotationTransition(
          turns: animation,
          child: _buildChild(),
        ),
      ),
    );
  }

  Widget _buildChild() {
    return const Icon(
      Icons.camera_outlined,
      color: Colors.green,
      size: 60,
    );
  }
}
