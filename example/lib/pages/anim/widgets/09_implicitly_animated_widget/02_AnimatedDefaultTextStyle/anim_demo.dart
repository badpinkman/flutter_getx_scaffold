import 'package:flutter/material.dart';

class AnimDemo extends StatefulWidget {
  const AnimDemo({super.key});

  @override
  State<AnimDemo> createState() => _AnimDemoState();
}

class _AnimDemoState extends State<AnimDemo> {
  final TextStyle startStyle = const TextStyle(
    color: Colors.white,
    fontSize: 50,
    shadows: [
      Shadow(
        offset: Offset(1, 1),
        color: Colors.black,
        blurRadius: 3,
      ),
    ],
  );

  final TextStyle endStyle = const TextStyle(
    color: Colors.white,
    fontSize: 20,
    shadows: [
      Shadow(
        offset: Offset(1, 1),
        color: Colors.purple,
        blurRadius: 3,
      )
    ],
  );

  late TextStyle _style;

  @override
  void initState() {
    super.initState();
    _style = startStyle;
  }

  bool get selected => _style == endStyle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Switch(value: selected, onChanged: onChanged),
          Container(
            color: Colors.grey.withAlpha(22),
            child: _buildAnim(),
          ),
        ],
      ),
    );
  }

  // 切换 _opacity 状态，重新构建
  void onChanged(bool value) {
    setState(() {
      _style = value ? endStyle : startStyle;
    });
  }

  _buildAnim() {
    return AnimatedDefaultTextStyle(
      textAlign: TextAlign.start,
      softWrap: true,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      curve: Curves.fastOutSlowIn,
      onEnd: onEnd,
      style: _style,
      duration: const Duration(seconds: 1),
      child: const Text('学习Animated'),
    );
  }

  void onEnd() {
    print('End');
  }
}
