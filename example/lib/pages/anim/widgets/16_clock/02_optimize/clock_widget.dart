import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClockWidget extends StatefulWidget {
  final double radius;
  const ClockWidget({super.key, this.radius = 100});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  final ValueNotifier<DateTime> _time = ValueNotifier<DateTime>(DateTime.now());
  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick)..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _time.dispose();
    super.dispose();
  }

  void _tick(Duration duration) {
    if (_time.value.second != DateTime.now().second) {
      _time.value = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CustomPaint(
            size: Size(widget.radius * 2, widget.radius * 2),
            painter: ClockBgPainter(radius: widget.radius),
          ),
          RepaintBoundary(
            child: CustomPaint(
              size: Size(widget.radius * 2, widget.radius * 2),
              painter: ClockPainter(listenable: _time, radius: widget.radius),
            ),
          ),
        ],
      ),
    );
  }
}

class ClockBgPainter extends CustomPainter {
  final Paint _paint = Paint()..style = PaintingStyle.stroke;
  final double radius;

  ClockBgPainter({this.radius = 100});

  /// 绘制外圆
  void drawOuterCircle(Canvas canvas) {
    _paint
      ..strokeWidth = 4
      ..color = const Color(0xffD5D5D5);
    for (int i = 0; i < 4; i++) {
      _paintArc(canvas);
      canvas.rotate(pi / 2);
    }
  }

  void _paintArc(Canvas canvas) {
    arcPaint.maskFilter = MaskFilter.blur(BlurStyle.solid, logic1);
    final Path circlePath = Path()
      ..addArc(
          Rect.fromCenter(
              center: Offset.zero, width: radius * 2, height: radius * 2),
          10 / 180 * pi,
          pi / 2 - 20 / 180 * pi);
    Path circlePath2 = Path()
      ..addArc(
          Rect.fromCenter(
              center: Offset(-logic1, 0),
              width: radius * 2,
              height: radius * 2),
          10 / 180 * pi,
          pi / 2 - 20 / 180 * pi);
    //联合路径
    Path result =
        Path.combine(PathOperation.difference, circlePath, circlePath2);
    canvas.drawPath(result, arcPaint); //绘制
  }

  /// 绘制刻度
  void drawScale(Canvas canvas) {
    _paint
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    double count = 60;
    double perAngle = 2 * pi / count;
    for (int i = 0; i < count; i++) {
      if (i % 5 == 0) {
        _paint
          ..strokeWidth = longLineWidth
          ..color = Colors.blue;
        canvas.drawLine(Offset(radius - scaleSpace, 0),
            Offset(radius - scaleSpace - longScaleLen, 0), _paint);
        canvas.drawCircle(
            Offset(radius - scaleSpace - longScaleLen - logic1 * 5, 0),
            longLineWidth,
            _paint..color = Colors.orange);
      } else {
        _paint
          ..strokeWidth = shortLenWidth
          ..color = Colors.black;
        canvas.drawLine(Offset(radius - scaleSpace, 0),
            Offset(radius - scaleSpace - shortScaleLen, 0), _paint);
      }
      canvas.rotate(perAngle);
    }
  }

  /// 绘制周围的4个文字 以及logo
  void drawText(Canvas canvas) {
    _drawCircleText(canvas, 'Ⅸ', offsetX: -radius);
    _drawCircleText(canvas, 'Ⅲ', offsetX: radius);
    _drawCircleText(canvas, 'Ⅵ', offsetY: radius);
    _drawCircleText(canvas, 'Ⅻ', offsetY: -radius);
    _drawLogoText(canvas, offsetY: -radius * 0.5);
  }

  /// 中间的logo
  void _drawLogoText(Canvas canvas, {double offsetX = 0, double offsetY = 0}) {
    _textPainter.text = TextSpan(
        text: 'Toly',
        style: TextStyle(
            fontSize: radius * 0.2, color: Colors.blue, fontFamily: 'CHOPS'));
    _textPainter.layout();
    _textPainter.paint(
        canvas,
        Offset.zero.translate(-_textPainter.size.width / 2 + offsetX,
            -_textPainter.height / 2 + offsetY));
  }

  final TextPainter _textPainter = TextPainter(
      textAlign: TextAlign.center, textDirection: TextDirection.ltr);

  _drawCircleText(Canvas canvas, String text,
      {double offsetX = 0, double offsetY = 0}) {
    _textPainter.text = TextSpan(
        text: text,
        style: TextStyle(fontSize: radius * 0.15, color: Colors.blue));
    _textPainter.layout();
    _textPainter.paint(
        canvas,
        Offset.zero.translate(-_textPainter.size.width / 2 + offsetX,
            -_textPainter.height / 2 + offsetY));
  }

  @override
  void paint(Canvas canvas, Size size) {
    print(
        '----Paint in ClockBgPainter ${DateTime.now().toIso8601String()}----');
    canvas.translate(size.width / 2, size.height / 2);
    drawOuterCircle(canvas);
    drawScale(canvas);
    drawText(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }

  double get logic1 => radius * 0.01;

  // 刻度与外圈的间隔
  double get scaleSpace => logic1 * 11;

  // 短刻度线长
  double get shortScaleLen => logic1 * 7;

  // 短刻度线长
  double get shortLenWidth => logic1;

  // 长刻度线长
  double get longScaleLen => logic1 * 11;

  // 长刻度线宽
  double get longLineWidth => logic1 * 2;

  final Paint arcPaint = Paint()
    ..style = PaintingStyle.fill
    ..color = const Color(0xff00abf2);
}

class ClockPainter extends CustomPainter {
  final ValueListenable<DateTime> listenable;
  final Paint _paint = Paint()..style = PaintingStyle.stroke;

  final double radius;

  ClockPainter({required this.listenable, this.radius = 100})
      : super(repaint: listenable);

  /// 绘制指针
  void drawArrow(Canvas canvas, DateTime time) {
    int sec = time.second;
    int min = time.minute;
    int hour = time.hour;

    double perAngle = 360 / 60;
    double secondRad = (sec * perAngle) / 180 * pi;
    double minusRad = ((min + sec / 60) * perAngle) / 180 * pi;
    double hourRad = ((hour + min / 60 + sec / 3600) * perAngle * 5) / 180 * pi;

    canvas.save();
    canvas.rotate(-pi / 2); // tag1: 将初始角度转到 0 刻度。

    canvas.save();
    canvas.rotate(minusRad);
    drawMinus(canvas);
    canvas.restore();

    canvas.save();
    canvas.rotate(hourRad);
    drawHour(canvas);
    canvas.restore();

    canvas.save();
    canvas.rotate(secondRad);
    drawSecond(canvas);
    canvas.restore();

    canvas.restore();
  }

  void drawHour(Canvas canvas) {
    _paint
      ..strokeWidth = hourLineWidth
      ..color = const Color(0xff8FC552)
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset.zero, Offset(hourLen, 0), _paint);
  }

  void drawMinus(Canvas canvas) {
    _paint
      ..strokeWidth = minusLineWidth
      ..color = const Color(0xff87B953)
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
        Offset.zero,
        Offset(
          minusLen,
          0,
        ),
        _paint);
  }

  void drawSecond(Canvas canvas) {
    _paint
      ..strokeWidth = logic1 * 2.5
      ..color = const Color(0xff6B6B6B)
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;
    Path path = Path();

    canvas.save();
    canvas.rotate((360 - 270) / 2 / 180 * pi);
    path.addArc(
        Rect.fromPoints(
            Offset(-logic1 * 9, -logic1 * 9), Offset(logic1 * 9, logic1 * 9)),
        0,
        270 / 180 * pi);
    canvas.drawPath(path, _paint);
    canvas.restore();

    _paint.strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(-logic1 * 9, 0), Offset(-logic1 * 20, 0), _paint);

    _paint
      ..strokeWidth = logic1
      ..color = Colors.black;
    canvas.drawLine(Offset.zero, Offset(secondLen, 0), _paint);

    _paint
      ..strokeWidth = logic1 * 3
      ..color = const Color(0xff6B6B6B);
    canvas.drawCircle(Offset.zero, logic1 * 5, _paint);

    _paint
      ..color = const Color(0xff8FC552)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, logic1 * 4, _paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    print('----Paint in ClockPainter ${DateTime.now().toIso8601String()}----');
    canvas.translate(size.width / 2, size.height / 2);
    drawArrow(canvas, listenable.value); //<----
  }

  @override
  bool shouldRepaint(covariant ClockPainter oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.listenable != listenable;
  }

  double get logic1 => radius * 0.01;

  double get minusLen => logic1 * 60; // 分针长
  double get hourLen => logic1 * 45; // 时针长
  double get secondLen => logic1 * 68; // 秒针长
  double get hourLineWidth => logic1 * 3; // 时针线宽
  double get minusLineWidth => logic1 * 2; // 分针线宽
  double get secondLineWidth => logic1; // 秒针线宽

  double get scaleSpace => logic1 * 11; // 刻度与外圈的间隔
  double get shortScaleLen => logic1 * 7; // 短刻度线长
  double get shortLenWidth => logic1; // 短刻度线长
  double get longScaleLen => logic1 * 11; // 长刻度线长
  double get longLineWidth => logic1 * 2; // 长刻度线宽
}
