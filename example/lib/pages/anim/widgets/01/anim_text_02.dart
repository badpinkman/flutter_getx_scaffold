import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// 彩虹文字
class AnimText extends StatefulWidget {
  const AnimText({super.key});

  @override
  State<AnimText> createState() => _AnimTextState();
}

class _AnimTextState extends State<AnimText>
    with SingleTickerProviderStateMixin {
  // 1. 声明动画器对象
  late AnimationController _ctrl;
  final Duration animDuration = const Duration(milliseconds: 1000); // 动画时长
  final List<Color> colors = [
    const Color(0xFFF60C0C),
    const Color(0xFFF3B913),
    const Color(0xFFE7F716),
    const Color(0xFF3DF30B),
    const Color(0xFF0DF6EF),
    const Color(0xFF0829FB),
    const Color(0xFFB709F4),
  ];

  final List<double> pos = [
    1.0 / 7,
    2.0 / 7,
    3.0 / 7,
    4.0 / 7,
    5.0 / 7,
    6.0 / 7,
    1.0
  ];
  @override
  void initState() {
    super.initState();
    // 1. 声明动画器对象
    _ctrl = AnimationController(vsync: this, duration: animDuration);
  }

  @override
  void dispose() {
    // 1. 销毁动画器
    _ctrl.dispose();
    super.dispose();
  }

  Paint getPaint() {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    paint.shader = ui.Gradient.linear(
      const Offset(0, 0),
      const Offset(100, 0),
      colors,
      pos,
      TileMode.mirror,
      Matrix4.rotationZ(pi / 6).storage,
    );
    paint.maskFilter = MaskFilter.blur(BlurStyle.solid, 15 * _ctrl.value);
    return paint;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnim,
      child: AnimatedBuilder(
        // 4.通过 AnimatedBuilder 监听动画器构建组件
        animation: _ctrl,
        builder: (BuildContext context, Widget? child) {
          return _buildByAnim(context, child);
        },
      ),
    );
  }

  Widget _buildByAnim(BuildContext context, Widget? child) {
    return Text(
      "张风捷特烈",
      style: TextStyle(fontSize: 60, foreground: getPaint()),
    );
  }

  void _startAnim() {
    // 3. 启动动画器
    _ctrl.forward(from: 0);
  }
}
