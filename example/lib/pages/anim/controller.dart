import 'package:getx_scaffold/common/index.dart';

class AnimController extends GetxController {
  AnimController();

  _initData() {
    update(["anim"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
