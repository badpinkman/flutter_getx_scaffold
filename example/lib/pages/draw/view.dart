import 'package:flutter/material.dart';
import 'package:getx_scaffold/common/index.dart';

import 'index.dart';

class DrawPage extends GetView<DrawController> {
  const DrawPage({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("DrawPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DrawController>(
      init: DrawController(),
      id: "draw",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text('绘图'.tr), elevation: 1),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
