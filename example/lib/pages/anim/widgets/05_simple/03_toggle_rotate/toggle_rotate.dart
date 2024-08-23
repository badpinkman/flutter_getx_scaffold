import 'dart:math';

import 'package:flutter/material.dart';

class ToggleRotate extends StatefulWidget {
  final Widget child;
  final ValueChanged<bool>? onEnd;
  final VoidCallback? onTap;
  final double beginAngle;
  final double endAngle;
  final int durationMs;
  final bool clockwise;
  final Curve curve;
  const ToggleRotate({
    super.key,
    this.onTap,
    this.onEnd,
    this.beginAngle = 0,
    this.endAngle = 90,
    this.clockwise = true,
    this.durationMs = 200,
    this.curve = Curves.fastOutSlowIn,
    required this.child,
  });

  @override
  State<ToggleRotate> createState() => _ToggleRotateState();
}

class _ToggleRotateState extends State<ToggleRotate>
    with SingleTickerProviderStateMixin {
  bool _rotated = false; // 是否已旋转
  late AnimationController _controller; // 是否动画控制器
  late Animation<double> _rotateAnim; // 旋转动画器

  double get rad => widget.clockwise ? _rotateAnim.value : -_rotateAnim.value;

  @override
  void initState() {
    super.initState();
    // 创建动画器
    _controller = AnimationController(
        duration: Duration(milliseconds: widget.durationMs), vsync: this);
    // 初始化 Tween
    _initTweenAnim();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initTweenAnim() {
    _rotateAnim = Tween<double>(
            begin: widget.beginAngle / 180 * pi,
            end: widget.endAngle / 180 * pi)
        .chain(CurveTween(curve: widget.curve))
        .animate(_controller);
  }

  void _toggleRotate() async {
    widget.onTap?.call();
    if (_rotated) {
      await _controller.reverse();
    } else {
      await _controller.forward();
    }
    _rotated = !_rotated;
    widget.onEnd?.call(_rotated);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _toggleRotate,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => Transform(
          transform: Matrix4.rotationZ(rad),
          alignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }
}
