import 'package:flutter/material.dart';

class AnimDemo extends StatefulWidget {
  const AnimDemo({super.key});

  @override
  State<AnimDemo> createState() => _AnimDemoState();
}

class _AnimDemoState extends State<AnimDemo> {
  final Alignment startAlignment = Alignment.center;
  final Alignment endAlignment = Alignment.bottomRight;

  late Alignment _alignment;

  @override
  void initState() {
    super.initState();
    _alignment = startAlignment;
  }

  bool get selected => _alignment == endAlignment;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Switch(value: selected, onChanged: onChanged),
          Container(
            width: 200,
            height: 100,
            color: Colors.grey.withAlpha(22),
            alignment: Alignment.center,
            child: _buildAnim(),
          ),
        ],
      ),
    );
  }

  // 切换 _opacity 状态，重新构建
  void onChanged(bool value) {
    setState(() {
      _alignment = value ? endAlignment : startAlignment;
    });
  }

  _buildAnim() {
    return AnimatedAlign(
      curve: Curves.fastOutSlowIn,
      onEnd: onEnd,
      alignment: _alignment,
      duration: const Duration(seconds: 1),
      child: const Icon(
        Icons.accessible_forward_sharp,
        color: Colors.green,
        size: 25,
      ),
    );
  }

  void onEnd() {
    print('End');
  }
}
