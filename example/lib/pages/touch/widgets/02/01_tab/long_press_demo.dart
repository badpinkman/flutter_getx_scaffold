import 'package:flutter/material.dart';

class LongPressDemo extends StatelessWidget {
  const LongPressDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _onLongPress,
      onLongPressStart: _onLongPressStart,
      onLongPressEnd: _onLongPressEnd,
      onLongPressUp: _onLongPressUp,
      onLongPressMoveUpdate: _onLongPressMoveUpdate,
      child: Container(
        color: Colors.blue,
        height: 100,
        width: 100,
      ),
    );
  }

  void _onLongPressStart(LongPressStartDetails details) {
    print('----- 1 长按开始-localPosition:--${details.localPosition}--'
        '--globalPosition:--${details.globalPosition}--');
  }

  void _onLongPress() {
    print('----- 2 长按---------');
  }

  void _onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    print('----- 3 长按触点移动:'
        'localPosition:${parserOffset(details.localPosition)};'
        'globalPosition:${parserOffset(details.globalPosition)};'
        'offsetFromOrigin:${parserOffset(details.offsetFromOrigin)};'
        'localOffsetFromOrigin:${parserOffset(details.localOffsetFromOrigin)};');
  }

  void _onLongPressUp() {
    print('----- 5 长按抬起---------');
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    print('----- 4 长按结束--'
        '--localPosition:--${details.localPosition}--'
        '--globalPosition:--${details.globalPosition}--'
        '--velocity:--${details.velocity}--');
  }

  String parserOffset(Offset offset) {
    return '(${offset.dx.toStringAsFixed(2)},${offset.dy.toStringAsFixed(2)})';
  }
}
