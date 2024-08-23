import 'package:flutter/material.dart';

/// 闪烁头像
class CircleShineImage extends StatefulWidget {
  final double maxBlurRadius;
  final Color color;
  final Duration duration;
  final Curve curve;
  final ImageProvider image;
  final double radius;

  const CircleShineImage(
      {super.key,
      this.maxBlurRadius = 10,
      this.color = Colors.purple,
      this.duration = const Duration(milliseconds: 2000),
      this.curve = Curves.ease,
      this.radius = 30,
      required this.image});

  @override
  State<CircleShineImage> createState() => _CircleShineImageState();
}

class _CircleShineImageState extends State<CircleShineImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl; // 声明：动画控制器
  late Animation<double> blurRadiusAnim; // 声明：阴影半径动画器

  @override
  void initState() {
    super.initState();
    // 实例化:动画控制器
    _ctrl = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(_handleAnimationChanged);

    // 实例化:阴影半径动画器
    blurRadiusAnim = Tween<double>(begin: 0, end: widget.maxBlurRadius)
        .chain(CurveTween(curve: widget.curve))
        .animate(_ctrl);

    _ctrl.repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _handleAnimationChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.radius * 2,
      width: widget.radius * 2,
      decoration: BoxDecoration(
        image: DecorationImage(image: widget.image, fit: BoxFit.cover),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: widget.color,
            blurRadius: blurRadiusAnim.value,
            spreadRadius: 0,
          )
        ],
      ),
    );
  }
}
