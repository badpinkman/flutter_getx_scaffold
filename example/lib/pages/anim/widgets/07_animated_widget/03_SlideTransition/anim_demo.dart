import 'package:flutter/material.dart';

class AnimDemo extends StatefulWidget {
  const AnimDemo({super.key});

  @override
  State<AnimDemo> createState() => _AnimDemoState();
}

class _AnimDemoState extends State<AnimDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.5, 0.5),
    )
        .chain(
          CurveTween(curve: Curves.ease),
        )
        .animate(_ctrl);
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
      child: Center(
        child: Container(
          color: Colors.grey.withAlpha(22),
          width: 100,
          height: 100,
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildChild() {
    return const Icon(
      Icons.accessible_forward_sharp,
      color: Colors.green,
      size: 25,
    );
  }

  Widget _buildContent() {
    return Stack(
      fit: StackFit.expand,
      children: [
        SlideTransition(
          textDirection: TextDirection.ltr,
          position: animation,
          child: _buildChild(),
        ),
        SlideTransition(
          textDirection: TextDirection.rtl,
          position: animation,
          child: _buildChild(),
        ),
      ],
    );
  }
}
