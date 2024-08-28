import 'package:flutter/material.dart';

class AnimDemo extends StatefulWidget {
  const AnimDemo({super.key});

  @override
  State<AnimDemo> createState() => _AnimDemoState();
}

class _AnimDemoState extends State<AnimDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late AnimatedIconData _icon;
  final AnimatedIconData startIcon = AnimatedIcons.close_menu;
  final AnimatedIconData endIcon = AnimatedIcons.menu_close;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _icon = startIcon;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  bool get closed => _icon == endIcon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (closed) {
            _icon = startIcon;
          } else {
            _icon = endIcon;
          }
        });
        _ctrl.forward(from: 0);
      },
      child: Center(
        child: AnimatedIcon(
          icon: _icon,
          progress: _ctrl,
          size: 50,
          color: Colors.green,
        ),
      ),
    );
  }
}
