import 'package:get/get.dart';

import '../classes/classes_controller.dart';
import 'class_info_controller.dart';

class ClassInfoBindings extends Bindings {
  @override
  void dependencies() {
    // Controllers
    Get.lazyPut(
      () => ClassInfoController(),
    );
    Get.lazyPut(
      () => ClassesController(),
    );
  }
}
