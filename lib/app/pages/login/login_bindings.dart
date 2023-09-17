import 'package:get/get.dart';

import 'login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.lazyPut(() => LoginController());
  }
}
