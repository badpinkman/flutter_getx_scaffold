import 'dart:math';

import 'package:flutter/material.dart';

import '../coordinate.dart';

/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸

class Paper extends StatelessWidget {
  const Paper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        // 使用CustomPaint
        painter: PaperPainter(),
        size: Size.infinite,
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  final Coordinate coordinate = Coordinate();

  late Paint _paint;

  final double strokeWidth = 0.5;
  final Color color = Colors.blue;

  PaperPainter() {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    _drawFill(canvas);
  }

  void _drawFill(Canvas canvas) {
    canvas.save();
    canvas.translate(-200, 0);
    canvas.drawCircle(const Offset(0, 0), 60, _paint);
    canvas.restore();

    var rect =
        Rect.fromCenter(center: const Offset(0, 0), height: 100, width: 120);
    canvas.drawOval(rect, _paint);

    canvas.save();
    canvas.translate(200, 0);
    //drawArc(矩形区域,起始弧度,扫描弧度,是否连中心,画笔)
    canvas.drawArc(rect, 0, pi / 2 * 3, true, _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
