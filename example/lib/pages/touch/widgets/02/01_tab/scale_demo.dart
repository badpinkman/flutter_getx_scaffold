import 'package:flutter/material.dart';

class ScaleDemo extends StatelessWidget {
  const ScaleDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _onScaleStart,
      onScaleUpdate: _onScaleUpdate,
      onScaleEnd: _onScaleEnd,
      child: Container(color: Colors.blue, height: 80),
    );
  }

  void _onScaleStart(ScaleStartDetails details) {
    print('缩放开始 1 :'
        'focalPoint:${parserOffset(details.focalPoint)};'
        'localFocalPoint:${parserOffset(details.localFocalPoint)};'
        'pointerCount:${details.pointerCount};');
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    print('缩放中 2 :'
        'focalPoint:${parserOffset(details.focalPoint)};'
        'localFocalPoint:${parserOffset(details.localFocalPoint)};'
        'pointerCount:${details.pointerCount};'
        'scale:${details.scale};'
        'horizontalScale:${details.horizontalScale};'
        'verticalScale:${details.verticalScale};'
        'rotation:${details.rotation};');
  }

  void _onScaleEnd(ScaleEndDetails details) {
    print('缩放结束 3 :'
        'velocity:${details.velocity};'
        'pointerCount:${details.pointerCount};');
  }

  String parserOffset(Offset offset) {
    return '(${offset.dx.toStringAsFixed(2)},${offset.dy.toStringAsFixed(2)})';
  }
}
