import 'dart:math';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com lib/p03_canvas/02_operation_scale_grid
/// 说明: 纸

class PaperWidget3 extends StatelessWidget {
  const PaperWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      // 使用CustomPaint
      painter: PaperPainter(),
      size: Size.infinite,
    );
  }
}

class PaperPainter extends CustomPainter {
  late Paint _gridPint; // 画笔
  final double step = 20; // 小格边长
  final double strokeWidth = .5; // 线宽
  final Color color = Colors.grey; // 线颜色

  PaperPainter() {
    _gridPint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    _drawGrid(canvas, size);
    _drawPart(canvas);
    _drawDot(canvas, _gridPint);
  }

  void _drawDot(Canvas canvas, Paint paint) {
    const int count = 12;
    paint
      ..color = Colors.orangeAccent
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.save();
    for (int i = 0; i < count; i++) {
      var step = 2 * pi / count;
      canvas.drawLine(const Offset(80, 0), const Offset(100, 0), paint);
      canvas.rotate(step);
    }
    canvas.restore();
  }

  void _drawPart(Canvas canvas) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;
    canvas.drawCircle(const Offset(0, 0), 50, paint);
    canvas.drawLine(
        const Offset(20, 20),
        const Offset(50, 50),
        paint
          ..color = Colors.red
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);
  }

  void _drawGrid(Canvas canvas, Size size) {
    _drawBottomRight(canvas, size);
    //
    canvas.save();
    canvas.scale(1, -1); //沿x轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();
    //
    canvas.save();
    canvas.scale(-1, 1); //沿y轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();
    //
    canvas.save();
    canvas.scale(-1, -1); //沿原点镜像
    _drawBottomRight(canvas, size);
    canvas.restore();
  }

  void _drawBottomRight(Canvas canvas, Size size) {
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      canvas.drawLine(const Offset(0, 0), Offset(size.width / 2, 0), _gridPint);
      canvas.translate(0, step);
    }
    canvas.restore();

    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      canvas.drawLine(
          const Offset(0, 0), Offset(0, size.height / 2), _gridPint);
      canvas.translate(step, 0);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
