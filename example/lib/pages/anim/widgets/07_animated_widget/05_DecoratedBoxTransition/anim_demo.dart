import 'package:flutter/material.dart';

class AnimDemo extends StatefulWidget {
  const AnimDemo({super.key});

  @override
  State<AnimDemo> createState() => _AnimDemoState();
}

class _AnimDemoState extends State<AnimDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Decoration> animation;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = DecorationTween(
      begin: const BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            color: Colors.purple,
            blurRadius: 5,
            spreadRadius: 2,
          )
        ],
      ),
      end: const BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
              offset: Offset(1, 1),
              color: Colors.blue,
              blurRadius: 10,
              spreadRadius: 0),
        ],
      ),
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
          child: DecoratedBoxTransition(
            position: DecorationPosition.background,
            decoration: animation,
            child: _buildChild(),
          ),
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
}
