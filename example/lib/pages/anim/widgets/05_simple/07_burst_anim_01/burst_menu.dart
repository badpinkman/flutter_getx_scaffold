import 'dart:math';

import 'package:flutter/material.dart';

typedef BurstMenuItemClick = bool Function(int index);

/// 爆炸菜单按钮
class BurstMenu extends StatefulWidget {
  final List<Widget> menus;
  final Widget center;
  final BurstMenuItemClick? burstMenuItemClick;
  const BurstMenu({
    super.key,
    required this.menus,
    required this.center,
    this.burstMenuItemClick,
  });

  @override
  State<BurstMenu> createState() => _BurstMenuState();
}

class _BurstMenuState extends State<BurstMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // 是否已关闭
  bool _closed = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 控制菜单点击
  void _handleItemClick(int index) {
    if (widget.burstMenuItemClick == null) {
      toggle();
      return;
    }
    bool? close = widget.burstMenuItemClick!.call(index);
    if (close) toggle();
  }

  void toggle() {
    if (_closed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _closed = !_closed;
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _CircleFlowDelegate(_controller),
      children: [
        ...widget.menus.asMap().keys.map((int index) => GestureDetector(
              onTap: () => {_handleItemClick(index)},
              child: widget.menus[index],
            )),
        GestureDetector(
          onTap: toggle,
          child: widget.center,
        )
      ],
    );
  }
}

class _CircleFlowDelegate extends FlowDelegate {
  // 菜单圆弧的扫描角度
  final double swapAngle;

  // 菜单圆弧的起始角度
  final double startAngle;

  final Animation<double> animation;

  _CircleFlowDelegate(
    this.animation, {
    this.swapAngle = 140,
    this.startAngle = -250,
  }) : super(repaint: animation);

  //绘制孩子的方法
  @override
  void paintChildren(FlowPaintingContext context) {
    double radius = context.size.shortestSide / 2;
    final int count = context.childCount - 1;

    final double perRad = swapAngle / 180 * pi / (count - 1);
    double rotate = startAngle / 180 * pi;

    for (int i = 0; i < count; i++) {
      final double cSizeX = context.getChildSize(i)!.width / 2;
      final double cSizeY = context.getChildSize(i)!.height / 2;

      final double offsetX =
          animation.value * (radius - cSizeX) * cos(i * perRad + rotate) +
              radius;
      final double offsetY =
          animation.value * (radius - cSizeY) * sin(i * perRad + rotate) +
              radius;

      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          offsetX - cSizeX,
          offsetY - cSizeY,
          0.0,
        ),
        opacity: animation.value,
      );
    }

    context.paintChild(
      context.childCount - 1,
      transform: Matrix4.translationValues(
        radius - context.getChildSize(context.childCount - 1)!.width / 2,
        radius - context.getChildSize(context.childCount - 1)!.height / 2,
        0.0,
      ),
    );
  }

  @override
  bool shouldRepaint(_CircleFlowDelegate oldDelegate) =>
      swapAngle != oldDelegate.swapAngle ||
      startAngle != oldDelegate.startAngle;
}
