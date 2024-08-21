import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class AnimText extends StatelessWidget {
  final String text = "学习动画";

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

  AnimText({super.key});

  Paint getPaint() {
    Paint paint = Paint();
    paint
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
    paint.maskFilter = const MaskFilter.blur(BlurStyle.solid, 10);
    return paint;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 60, foreground: getPaint()),
    );
  }
}
