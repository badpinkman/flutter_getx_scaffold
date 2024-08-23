import 'dart:math';

import 'package:getx_scaffold/common/index.dart';

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
    required this.child,
    this.onTap,
    this.onEnd,
    this.beginAngle = 0,
    this.endAngle = 90,
    this.clockwise = true,
    this.durationMs = 200,
    this.curve = Curves.fastOutSlowIn,
  });

  @override
  State<ToggleRotate> createState() => _ToggleRotateState();
}

class _ToggleRotateState extends State<ToggleRotate>
    with SingleTickerProviderStateMixin {
  bool _rotated = false;
  late AnimationController _controller;
  late Animation<double> _rotateAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: widget.durationMs), vsync: this);
    _initTweenAnim();
  }

  void _initTweenAnim() {
    _rotateAnim = Tween<double>(
            begin: widget.beginAngle / 180 * pi,
            end: widget.endAngle / 180 * pi)
        .chain(CurveTween(curve: widget.curve))
        .animate(_controller);
  }

  @override
  void didUpdateWidget(ToggleRotate oldWidget) {
    super.didUpdateWidget(oldWidget);

    Logger.d('更新 ${oldWidget.beginAngle} ${widget.durationMs}');

    if (widget.durationMs != oldWidget.durationMs) {
      Logger.d('更新1111111');
      _controller.dispose();
      _controller = AnimationController(
          duration: Duration(milliseconds: widget.durationMs), vsync: this);
    }
    if (widget.beginAngle != oldWidget.beginAngle ||
        widget.endAngle != oldWidget.endAngle ||
        widget.curve != oldWidget.curve ||
        widget.durationMs != oldWidget.durationMs) {
      Logger.d('更新 222222');
      _initTweenAnim();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get rad => widget.clockwise ? _rotateAnim.value : -_rotateAnim.value;

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
        builder: (_, child) => Transform(
          transform: Matrix4.rotationZ(rad),
          alignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }
}
