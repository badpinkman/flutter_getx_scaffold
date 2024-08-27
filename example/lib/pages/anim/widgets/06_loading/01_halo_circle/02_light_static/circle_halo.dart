import 'package:flutter/material.dart';

class CircleHalo extends StatefulWidget {
  const CircleHalo({super.key});

  @override
  State<CircleHalo> createState() => _CircleHaloState();
}

class _CircleHaloState extends State<CircleHalo> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: CircleHaloPainter(),
    );
  }
}

class CircleHaloPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    final Paint paint = Paint()..style = PaintingStyle.stroke;
    // 设置 maskFilter
    paint.maskFilter = const MaskFilter.blur(BlurStyle.solid, 4);

    //路径1
    final Path circlePath = Path()
      ..addOval(
          Rect.fromCenter(center: const Offset(0, 0), width: 100, height: 100));
    //路径2
    Path circlePath2 = Path()
      ..addOval(Rect.fromCenter(
          center: const Offset(-1, 0), width: 100, height: 100));
    Path result =
        Path.combine(PathOperation.difference, circlePath, circlePath2);
    //颜色填充
    paint
      ..style = PaintingStyle.fill
      ..color = const Color(0xff00abf2);
    canvas.drawPath(result, paint); //绘制
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
