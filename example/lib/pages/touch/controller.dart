import 'package:getx_scaffold/common/index.dart';

class TouchController extends GetxController {
  TouchController();

  _initData() {
    update(["touch"]);
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
