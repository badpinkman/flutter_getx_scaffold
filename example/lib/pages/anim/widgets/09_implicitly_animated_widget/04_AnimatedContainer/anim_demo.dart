import 'package:flutter/material.dart';

class AnimDemo extends StatefulWidget {
  const AnimDemo({super.key});

  @override
  State<AnimDemo> createState() => _AnimDemoState();
}

class _AnimDemoState extends State<AnimDemo> {
  final Decoration startDecoration = const BoxDecoration(
    color: Colors.deepPurple,
    borderRadius: BorderRadius.all(Radius.circular(30)),
    boxShadow: [
      BoxShadow(
        offset: Offset(1, 1),
        color: Colors.purple,
        blurRadius: 5,
        spreadRadius: 2,
      ),
    ],
  );

  final Decoration endDecoration = const BoxDecoration(
    color: Colors.blueAccent,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    boxShadow: [
      BoxShadow(
        offset: Offset(1, 1),
        color: Colors.blue,
        blurRadius: 10,
        spreadRadius: 0,
      ),
    ],
  );

  final Alignment startAlignment =
      Alignment.topLeft + const Alignment(0.2, 0.2);
  final Alignment endAlignment = Alignment.center;

  final double startHeight = 150.0;
  final double endHeight = 100.0;

  late Decoration _decoration;
  late double _height;
  late Alignment _alignment;

  @override
  void initState() {
    super.initState();
    _decoration = startDecoration;
    _height = startHeight;
    _alignment = startAlignment;
  }

  bool get selected => _height == endHeight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Switch(value: selected, onChanged: onChanged),
          _buildAnim(),
        ],
      ),
    );
  }

  // 切换 _opacity 状态，重新构建
  void onChanged(bool value) {
    setState(() {
      _height = value ? endHeight : startHeight;
      _decoration = value ? endDecoration : startDecoration;
      _alignment = value ? endAlignment : startAlignment;
    });
  }

  _buildAnim() {
    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      decoration: _decoration,
      duration: const Duration(seconds: 1),
      alignment: _alignment,
      onEnd: onEnd,
      height: _height,
      width: _height,
      child: _buildChild(),
    );
  }

  void onEnd() {
    print('End');
  }

  _buildChild() {
    return const Icon(
      Icons.camera_outlined,
      size: 30,
      color: Colors.white,
    );
  }
}
