import 'package:example/pages/anim/widgets/06_loading/04_light_anim/circle_halo.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return const CircleHalo();
  }
}
