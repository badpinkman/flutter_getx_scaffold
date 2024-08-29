import 'package:flutter/material.dart';

/// 平移
class PanDemo extends StatelessWidget {
  const PanDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanDown: _onPanDown,
      onPanEnd: _onPanEnd,
      onPanCancel: _onPanCancel,
      onPanUpdate: _onPanUpdate,
      child: Container(
        color: Colors.blue,
        height: 100,
        width: 100,
      ),
    );
  }

  void _onPanDown(DragDownDetails details) {
    print('按下平移按钮 1 :'
        'localPosition:${parserOffset(details.localPosition)};'
        'globalPosition:${parserOffset(details.globalPosition)};');
  }

  void _onPanStart(DragStartDetails details) {
    print('平移开始 2 :'
        'localPosition:${parserOffset(details.localPosition)};'
        'globalPosition:${parserOffset(details.globalPosition)};'
        'sourceTimeStamp:${details.sourceTimeStamp};'
        'kind:${details.kind};');
  }

  void _onPanUpdate(DragUpdateDetails details) {
    print('平移 3 :'
        'localPosition:${parserOffset(details.localPosition)};'
        'globalPosition:${parserOffset(details.globalPosition)};'
        'sourceTimeStamp:${details.sourceTimeStamp};'
        'delta:${details.delta};'
        'primaryDelta:${details.primaryDelta};');
  }

  void _onPanEnd(DragEndDetails details) {
    print('平移结束 4 :'
        'velocity:${details.velocity};'
        'primaryVelocity:${details.primaryVelocity};');
  }

  void _onPanCancel() {
    print('-----取消平移---------');
  }

  String parserOffset(Offset offset) {
    return '(${offset.dx.toStringAsFixed(2)},${offset.dy.toStringAsFixed(2)})';
  }
}
