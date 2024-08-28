import 'package:flutter/material.dart';

class AnimDemo extends StatefulWidget {
  const AnimDemo({super.key});

  @override
  State<AnimDemo> createState() => _AnimDemoState();
}

class _AnimDemoState extends State<AnimDemo> {
  final double beginOpacity = 1.0; // 开始透明度
  final double endOpacity = 0; // 结束透明度

  late double _opacity; // 当前透明度

  bool get selected => _opacity == 0;

  @override
  void initState() {
    super.initState();
    _opacity = beginOpacity;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Switch(value: selected, onChanged: onChanged),
          Container(
            color: Colors.grey.withAlpha(22),
            width: 100,
            height: 100,
            child: _buildAnimatedOpacity(),
          ),
        ],
      ),
    );
  }

  // 切换 _opacity 状态，重新构建
  void onChanged(bool value) {
    setState(() {
      _opacity = value ? endOpacity : beginOpacity;
    });
  }

  _buildAnimatedOpacity() {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      opacity: _opacity,
      onEnd: onEnd,
      child: _buildChild(),
    );
  }

  void onEnd() {
    print('End');
  }

  _buildChild() {
    return const Icon(
      Icons.camera_outlined,
      color: Colors.green,
      size: 60,
    );
  }
}
