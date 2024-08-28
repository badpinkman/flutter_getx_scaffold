import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimDemo extends StatefulWidget {
  const AnimDemo({super.key});

  @override
  State<AnimDemo> createState() => _AnimDemoState();
}

class _AnimDemoState extends State<AnimDemo>
    with SingleTickerProviderStateMixin {
  bool _animating = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Switch(
            value: _animating,
            onChanged: onChanged,
          ),
          CupertinoActivityIndicator(
            animating: _animating,
            radius: 20,
          ),
        ],
      ),
    );
  }

  void onChanged(bool value) {
    setState(() {
      _animating = !_animating;
    });
  }
}
