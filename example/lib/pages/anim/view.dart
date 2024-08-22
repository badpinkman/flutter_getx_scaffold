import 'package:flutter/material.dart';
import 'package:getx_scaffold/common/index.dart';

import 'index.dart';
import 'widgets/02_skew_shadow/skew_show_text.dart';

class AnimPage extends GetView<AnimController> {
  const AnimPage({super.key});

  // 主视图
  Widget _buildView() {
    return SkewShadowText();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnimController>(
      init: AnimController(),
      id: "anim",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text('动画'.tr), elevation: 1),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
