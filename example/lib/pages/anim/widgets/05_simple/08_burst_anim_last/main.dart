import 'package:flutter/material.dart';

import '../08_burst_anim_last/burst_menu.dart';

/// 爆炸按钮最终版
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
          .map(
            (Color color) => Container(
              width: 15.0 * 2,
              height: 15.0 * 2,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
          )
          .toList();

  bool _burstMenuItemClick(int index) {
    print("index:$index");
    if (index == 0) {
      return false; // 当点击第 0 个时，菜单不收起。
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 20,
          top: 20,
          child: BurstMenu.topRight(
            curve: Curves.bounceOut,
            radius: 60,
            center: _buildMenu(),
            burstMenuItemClick: _burstMenuItemClick,
            menus: _buildMenuItems(),
          ),
        ),
        Positioned(
          left: 20,
          top: 20,
          child: BurstMenu.topLeft(
            curve: Curves.linearToEaseOut,
            radius: 60,
            center: _buildMenu(),
            burstMenuItemClick: _burstMenuItemClick,
            menus: _buildMenuItems(),
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: BurstMenu.bottomRight(
            curve: Curves.decelerate,
            radius: 60,
            center: _buildMenu(),
            burstMenuItemClick: _burstMenuItemClick,
            menus: _buildMenuItems(),
          ),
        ),
        Positioned(
          left: 20,
          bottom: 20,
          child: BurstMenu.bottomLeft(
            curve: Curves.easeOutQuart,
            radius: 60,
            center: _buildMenu(),
            burstMenuItemClick: _burstMenuItemClick,
            menus: _buildMenuItems(),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2 - 120,
          bottom: 80,
          child: BurstMenu(
            radius: 120,
            burstType: BurstType.halfCircle,
            startAngle: -150,
            swapAngle: 90.0 + 30,
            center: _buildMenu(),
            burstMenuItemClick: _burstMenuItemClick,
            menus: _buildMenuItems(),
          ),
        ),
      ],
    );

    //     Center(
    //   child: IconTheme(
    //     data: IconTheme.of(context).copyWith(color: Colors.white, size: 18),
    //     child: Wrap(
    //       children: [
    //         BurstMenu(
    //           radius: 100,
    //           burstType: BurstType.circle,
    //           center: _buildMenu(),
    //           burstMenuItemClick: _burstMenuItemClick,
    //           menus: _buildMenuItems(),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
