import 'dart:math';

import 'package:flutter/material.dart';

/// 文字阴影效果
class SkewShadowText extends StatefulWidget {
  const SkewShadowText({super.key});

  @override
  State<SkewShadowText> createState() => _SkewShadowTextState();
}

class _SkewShadowTextState extends State<SkewShadowText>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final Duration animDuration = const Duration(milliseconds: 800);

  final TextStyle commonStyle =
      const TextStyle(fontSize: 60, color: Colors.blue);

  final TextStyle shadowStyle =
      TextStyle(fontSize: 60, color: Colors.blue.withAlpha(88));

  final String text = '张风捷特烈';

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: animDuration);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  double get rad => 6 * (_ctrl.value) / 180 * pi;

  Widget _buildByAnim(_, __) => Transform(
        transform: Matrix4.skewX(rad),
        child: Text(
          text,
          style: shadowStyle,
        ),
      );

  void _startAnim() {
    _ctrl.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnim,
      child: Stack(
        children: [
          Text(
            text,
            style: commonStyle,
          ),
          AnimatedBuilder(
            animation: _ctrl,
            builder: _buildByAnim,
          ),
        ],
      ),
    );
  }
}
