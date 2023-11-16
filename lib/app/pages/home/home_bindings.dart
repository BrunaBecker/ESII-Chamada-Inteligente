import 'package:get/get.dart';

import 'home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.lazyPut(
      () => HomeController(),
    );
  }
}
