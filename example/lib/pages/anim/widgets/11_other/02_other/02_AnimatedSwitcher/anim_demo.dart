import 'package:flutter/material.dart';

class AnimDemo extends StatefulWidget {
  const AnimDemo({super.key});

  @override
  State<AnimDemo> createState() => _AnimDemoState();
}

class _AnimDemoState extends State<AnimDemo> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        _buildBtn(Icons.remove, Colors.red, _doMinus),
        SizedBox(width: 80, child: _buildAnimatedSwitcher(context)),
        _buildBtn(Icons.add, Colors.blue, _doAdd)
      ],
    );
  }

  Widget _buildAnimatedSwitcher(BuildContext context) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            ScaleTransition(
                scale: animation,
                child: RotationTransition(turns: animation, child: child)),
        child: Text(
          '$_count',
          key: ValueKey<int>(_count),
          style: Theme.of(context).textTheme.displayMedium,
        ),
      );

  Widget _buildBtn(IconData icon, Color color, VoidCallback onPressed) =>
      MaterialButton(
          padding: EdgeInsets.zero,
          textColor: const Color(0xffFfffff),
          elevation: 3,
          color: color,
          highlightColor: const Color(0xffF88B0A),
          splashColor: Colors.red,
          shape: const CircleBorder(
            side: BorderSide(width: 2.0, color: Color(0xffffdfdfdf)),
          ),
          onPressed: onPressed,
          child: Icon(
            icon,
            color: Colors.white,
          ));

  void _doMinus() {
    setState(() => _count -= 1);
  }

  void _doAdd() {
    setState(() => _count += 1);
  }
}
