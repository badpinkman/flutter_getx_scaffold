import 'package:flutter/material.dart';

import '../coordinate.dart';

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
  final double strokeWidth = .5;
  final Color color = Colors.blueAccent;

  PaperPainter() {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    // 画布居中
    canvas.translate(size.width / 2, size.height / 2);

    // 绘制矩形
    // _drawRect(canvas);

    // 圆角矩形
    // _drawRRect(canvas);

    _drawDRRect(canvas);
  }

  void _drawDRRect(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    Rect outRect =
        Rect.fromCenter(center: const Offset(0, 0), width: 160, height: 160);
    Rect inRect =
        Rect.fromCenter(center: const Offset(0, 0), width: 100, height: 100);
    canvas.drawDRRect(RRect.fromRectXY(outRect, 20, 20),
        RRect.fromRectXY(inRect, 20, 20), _paint);
    Rect outRect2 =
        Rect.fromCenter(center: const Offset(0, 0), width: 60, height: 60);
    Rect inRect2 =
        Rect.fromCenter(center: const Offset(0, 0), width: 40, height: 40);
    canvas.drawDRRect(RRect.fromRectXY(outRect2, 15, 15),
        RRect.fromRectXY(inRect2, 10, 10), _paint..color = Colors.green);
  }

  void _drawRRect(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    //【1】.圆角矩形fromRectXY构造
    Rect rectFromCenter =
        Rect.fromCenter(center: const Offset(0, 0), width: 160, height: 160);
    canvas.drawRRect(RRect.fromRectXY(rectFromCenter, 40, 20), _paint);

    //【2】.圆角矩形fromLTRBXY构造
    canvas.drawRRect(const RRect.fromLTRBXY(-120, -120, -80, -80, 10, 10),
        _paint..color = Colors.red);

    //【3】. 圆角矩形fromLTRBR构造
    canvas.drawRRect(
        RRect.fromLTRBR(80, -120, 120, -80, const Radius.circular(10)),
        _paint..color = Colors.orange);

    //【4】. 圆角矩形fromLTRBAndCorners构造
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(80, 80, 120, 120,
            bottomRight: const Radius.elliptical(10, 10)),
        _paint..color = Colors.green);

    //【5】. 矩形两点构造
    Rect rectFromPoints =
        Rect.fromPoints(const Offset(-120, 80), const Offset(-80, 120));
    canvas.drawRRect(
        RRect.fromRectAndCorners(rectFromPoints,
            bottomLeft: const Radius.elliptical(10, 10)),
        _paint..color = Colors.purple);
  }

  void _drawRect(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    //【1】.矩形中心构造
    Rect rectFromCenter =
        Rect.fromCenter(center: const Offset(0, 0), width: 160, height: 160);
    canvas.drawRect(rectFromCenter, _paint);
    //【2】.矩形左上右下构造
    Rect rectFromLTRB = const Rect.fromLTRB(-120, -120, -80, -80);
    canvas.drawRect(rectFromLTRB, _paint..color = Colors.red);
    //【3】. 矩形左上宽高构造
    Rect rectFromLTWH = const Rect.fromLTWH(80, -120, 40, 40);
    canvas.drawRect(rectFromLTWH, _paint..color = Colors.orange);
    //【4】. 矩形内切圆构造
    Rect rectFromCircle =
        Rect.fromCircle(center: const Offset(100, 100), radius: 20);
    canvas.drawRect(rectFromCircle, _paint..color = Colors.green);
    //【5】. 矩形两点构造
    Rect rectFromPoints =
        Rect.fromPoints(const Offset(-120, 80), const Offset(-80, 120));
    canvas.drawRect(rectFromPoints, _paint..color = Colors.purple);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
