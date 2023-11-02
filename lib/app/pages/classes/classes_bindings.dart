import 'package:get/get.dart';

import 'classes_controller.dart';

class ClassesBindings extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.lazyPut(() => ClassesController());
  }
}
