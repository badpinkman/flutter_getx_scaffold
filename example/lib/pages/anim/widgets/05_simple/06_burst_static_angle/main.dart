import 'package:example/pages/anim/widgets/05_simple/06_burst_static_angle/burst_menu.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  // 构建中间菜单按钮
  Widget _buildMenu() => Container(
        width: 36,
        height: 36,
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('assets/images/icon_head.jpg')),
          ),
        ),
      );

  // 构建 菜单 item
  List<Widget> _buildMenuItems() => [
        Colors.red,
        Colors.yellow,
        Colors.blue,
        Colors.green,
        Colors.purple,
        Colors.indigo,
      ]
          .map((Color color) => Container(
                width: 15.0 * 2,
                height: 15.0 * 2,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(15.0))),
              ))
          .toList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        alignment: Alignment.center,
        child: IconTheme(
          data: IconTheme.of(context).copyWith(color: Colors.white, size: 18),
          child: BurstMenu(center: _buildMenu(), menus: _buildMenuItems()),
        ),
      ),
    );
  }
}
