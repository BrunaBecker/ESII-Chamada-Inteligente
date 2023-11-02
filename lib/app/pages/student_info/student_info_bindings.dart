import 'package:get/get.dart';

import 'student_info_controller.dart';

class StudentInfoBindings extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.lazyPut(
      () => StudentInfoController(),
    );
  }
}
