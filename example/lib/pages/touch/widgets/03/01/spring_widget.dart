import 'package:example/pages/touch/widgets/03/01/spring_painter.dart';
import 'package:flutter/material.dart';

class SpringWidget extends StatelessWidget {
  const SpringWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      color: Colors.grey.withAlpha(11),
      child: CustomPaint(
        painter: SpringPainter(height: 150),
      ),
    );
  }
}
