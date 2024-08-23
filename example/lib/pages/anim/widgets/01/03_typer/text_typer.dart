import 'dart:async';

import 'package:flutter/material.dart';

/// 打字机文字
class TextTyper extends StatefulWidget {
  const TextTyper({super.key});

  @override
  State<TextTyper> createState() => _TextTyperState();
}

class _TextTyperState extends State<TextTyper> {
  final Duration animDuration = const Duration(milliseconds: 200);

  final String text = '桃树、杏树、梨树，你不让我，我不让你，都开满了花赶趟儿。'
      '红的像火，粉的像霞，白的像雪。花里带着甜味，闭了眼，'
      '树上仿佛已经满是桃儿、杏儿、梨儿。';

  final ValueNotifier<String> data = ValueNotifier<String>("");

  late Timer _timer;
  int currentIndex = 0;

  String get currentText => text.substring(0, currentIndex);

  @override
  void initState() {
    super.initState();
    _startAnim();
  }

  @override
  void dispose() {
    _timer.cancel();
    data.dispose();
    super.dispose();
  }

  void _startAnim() {
    _timer = Timer.periodic(animDuration, _type);
    // _timer.cancel();
    data.value = '';
    currentIndex = 0;
  }

  void _type(Timer timer) {
    if (currentIndex < text.length) {
      currentIndex++;
      data.value = currentText;
    } else {
      _timer.cancel();
    }
  }

  Widget _buildByAnim(_, __) => Text(
        data.value,
        style: const TextStyle(color: Colors.blue),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnim,
      child: SizedBox(
        width: 300,
        child: AnimatedBuilder(
          animation: data,
          builder: _buildByAnim,
        ),
      ),
    );
  }
}
