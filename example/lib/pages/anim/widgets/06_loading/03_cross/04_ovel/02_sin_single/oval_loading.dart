import 'dart:math';

import 'package:flutter/material.dart';

class OvalLoading extends StatefulWidget {
  const OvalLoading({super.key});

  @override
  State<OvalLoading> createState() => _OvalLoadingState();
}

class _OvalLoadingState extends State<OvalLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: -pi, end: pi).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _ctrl.repeat,
        child: CustomPaint(
          size: const Size(150, 150),
          painter: OvalLoadingPainter(animation),
        ),
      ),
    );
  }
}

class OvalLoadingPainter extends CustomPainter {
  Animation<double> animation;

  OvalLoadingPainter(this.animation, {this.radius = 15, this.a = 0.4})
      : super(repaint: animation);

  final Paint _paint = Paint();
  final double radius;
  final double a;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Offset.zero & size, Paint()..color = Colors.grey.withAlpha(11));

    double zoneSize = size.shortestSide / 2;
    canvas.translate(size.width / 2, size.height / 2);

    double x = (zoneSize - radius) / pi * f(animation.value);
    double y = (zoneSize - radius) / 2 * g(animation.value);

    canvas.drawCircle(
        Offset(x, y), radius, _paint..color = const Color(0xffF44336));
  }

  double f(double t) => t;
  double g(double t) => sin(t);

  @override
  bool shouldRepaint(covariant OvalLoadingPainter oldDelegate) =>
      oldDelegate.a != a || oldDelegate.animation != animation;
}
