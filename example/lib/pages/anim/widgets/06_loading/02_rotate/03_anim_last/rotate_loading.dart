import 'dart:math';

import 'package:flutter/material.dart';

class RotateLoading extends StatefulWidget {
  const RotateLoading({super.key});

  @override
  State<RotateLoading> createState() => _RotateLoadingState();
}

class _RotateLoadingState extends State<RotateLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _ctrl.repeat,
      child: CustomPaint(
        size: Size.infinite,
        painter: RotateLoadingPainter(_ctrl),
      ),
    );
  }
}

class RotateLoadingPainter extends CustomPainter {
  final Animation<double> animation;
  final double itemWidth; //色块宽
  RotateLoadingPainter(this.animation, {this.itemWidth = 33})
      : super(repaint: animation);
  //画板
  final Paint _paint = Paint();
  //色块间隔
  final double span = 16;
  // 颜色
  final List<Color> colors = const [
    Color(0xffF44336),
    Color(0xff5C6BC0),
    Color(0xffFFB74D),
    Color(0xff8BC34A)
  ];

  final Animatable<double> rotateTween = Tween<double>(begin: pi, end: -pi)
      .chain(CurveTween(curve: Curves.easeIn));

  void drawItem(
    Canvas canvas,
    Offset center,
    Color color,
  ) {
    Rect rect = Rect.fromCenter(
      center: center,
      width: itemWidth,
      height: itemWidth,
    );
    canvas.save();
    canvas.translate(center.dx, center.dy); //<--- tag1 变换旋转中心
    canvas.rotate(rotateTween.evaluate(animation)); //<--- tag2 旋转
    canvas.translate(-center.dx, -center.dy); //<--- tag3 将旋转中心改回去
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(5)),
      _paint..color = color,
    );
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(animation.value * 2 * pi);
    final double len = itemWidth / 2 + span / 2;
    // 绘制红色
    Offset centerA = Offset(-len, -len);
    drawItem(canvas, centerA, colors[0]);

    // 绘制蓝色
    Offset centerB = Offset(len, len);
    drawItem(canvas, centerB, colors[1]);

    // 绘制橙色
    Offset centerC = Offset(len, -len);
    drawItem(canvas, centerC, colors[2]);

    // 绘制绿色
    Offset centerD = Offset(-len, len);
    drawItem(canvas, centerD, colors[3]);
  }

  @override
  bool shouldRepaint(covariant RotateLoadingPainter oldDelegate) =>
      oldDelegate.itemWidth != itemWidth;
}
