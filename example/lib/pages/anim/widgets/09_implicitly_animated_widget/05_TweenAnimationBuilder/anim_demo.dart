import 'package:flutter/material.dart';

class AnimDemo extends StatefulWidget {
  const AnimDemo({super.key});

  @override
  State<AnimDemo> createState() => _AnimDemoState();
}

class _AnimDemoState extends State<AnimDemo> {
  bool _selected = false;

  Color color1 = Colors.red;
  Color color2 = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Switch(value: _selected, onChanged: onChanged),
          _buildAnim(),
        ],
      ),
    );
  }

  // 切换 _opacity 状态，重新构建
  void onChanged(bool value) {
    setState(() {
      _selected = !_selected;
    });
  }

  Widget _buildAnim() {
    return TweenAnimationBuilder<Color>(
      tween: Tween<Color>(
        begin: Colors.blueAccent,
        end: _selected ? color1 : color2,
      ),
      duration: const Duration(seconds: 1),
      builder: (_, Color color, Widget? child) {
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        );
      },
      child: _buildChild(),
    );
  }

  void onEnd() {
    print('End');
  }

  _buildChild() {
    return const Icon(
      Icons.camera_outlined,
      size: 30,
      color: Colors.white,
    );
  }
}
