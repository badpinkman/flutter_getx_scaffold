import 'dart:math';

import 'package:flutter/material.dart';

class CrossLoading extends StatefulWidget {
  const CrossLoading({super.key});

  @override
  State<CrossLoading> createState() => _CrossLoadingState();
}

class _CrossLoadingState extends State<CrossLoading>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(100, 100),
        painter: CrossLoadingPainter(),
      ),
    );
  }
}

class CrossLoadingPainter extends CustomPainter {
  CrossLoadingPainter({this.itemWidth = 33});

  final List<Color> colors = const [
    Color(0xffF44336),
    Color(0xff5C6BC0),
    Color(0xffFFB74D),
    Color(0xff8BC34A),
  ];
  final double itemWidth;
  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Offset.zero & size, Paint()..color = Colors.grey.withAlpha(11));
    canvas.translate(size.width / 2, size.height / 2);

    final double offset = -size.height / 2 + itemWidth / sqrt(2);
    drawDiamond(canvas, offset, colors[0], true);
    drawDiamond(canvas, -offset, colors[1], true);
    drawDiamond(canvas, -offset, colors[2], false);
    drawDiamond(canvas, offset, colors[3], false);
  }

  void drawDiamond(
    Canvas canvas,
    double offset,
    Color color,
    bool vertical,
  ) {
    canvas.save();
    if (vertical) {
      canvas.translate(0, offset);
    } else {
      canvas.translate(offset, 0);
    }
    canvas.rotate(45 / 180 * pi);
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset.zero, width: itemWidth, height: itemWidth),
        _paint..color = color);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CrossLoadingPainter oldDelegate) =>
      oldDelegate.itemWidth != itemWidth;
}
