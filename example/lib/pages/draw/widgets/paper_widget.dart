import 'package:flutter/material.dart';

class PaperWidget extends StatelessWidget {
  const PaperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: CustomPaint(
        // 使用CustomPaint
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 创建画笔
    final Paint paint = Paint();
    // 绘制圆
    canvas.drawCircle(const Offset(100, 100), 10, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
