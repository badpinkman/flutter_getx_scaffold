import 'package:flutter/material.dart';
import 'package:getx_scaffold/common/index.dart';

import 'index.dart';

class TouchPage extends GetView<TouchController> {
  const TouchPage({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("TouchPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TouchController>(
      init: TouchController(),
      id: "touch",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("touch")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
