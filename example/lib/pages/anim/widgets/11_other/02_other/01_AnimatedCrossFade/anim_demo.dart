import 'package:flutter/material.dart';

class AnimDemo extends StatefulWidget {
  const AnimDemo({super.key});

  @override
  State<AnimDemo> createState() => _AnimDemoState();
}

class _AnimDemoState extends State<AnimDemo> {
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;
  bool get isFirst => _crossFadeState == CrossFadeState.showFirst;

  double imageHeight = 100;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Switch(
            value: isFirst,
            onChanged: _onChanged,
          ),
          AnimatedCrossFade(
            firstCurve: Curves.easeInCirc,
            secondCurve: Curves.easeInToLinear,
            sizeCurve: Curves.bounceOut,
            firstChild: buildFirstChild(),
            secondChild: buildSecondChild(),
            duration: const Duration(milliseconds: 1000),
            crossFadeState: _crossFadeState,
          ),
        ],
      ),
    );
  }

  Widget buildFirstChild() => Container(
        height: 60,
        width: 60,
        color: Colors.grey.withAlpha(22),
        alignment: Alignment.center,
        child: const FlutterLogo(
          size: 40,
        ),
      );

  Widget buildSecondChild() => Image.asset(
        "assets/images/icon_head.jpg",
        height: imageHeight,
        width: imageHeight,
      );

  void _onChanged(bool value) {
    setState(() {
      _crossFadeState =
          value ? CrossFadeState.showFirst : CrossFadeState.showSecond;
    });
  }
}
