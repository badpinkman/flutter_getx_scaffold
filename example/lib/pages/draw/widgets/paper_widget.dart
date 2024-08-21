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
    paint
      ..color = Colors.blue //颜色
      ..strokeWidth = 4 //线宽
      ..style = PaintingStyle.stroke; //模式--线型

    //绘制线
    canvas.drawLine(const Offset(0, 0), const Offset(100, 100), paint);

    Path path = Path();
    path.moveTo(100, 100);
    path.lineTo(200, 0);
    canvas.drawPath(path, paint..color = Colors.red);
  }

  void drawLine(Canvas canvas) {}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// class PaperPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     // 创建画笔
//     final Paint paint = Paint();
//     // 绘制圆
//     canvas.drawCircle(const Offset(100, 100), 10, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
