import 'package:get/get.dart';

import '../../core/adapters/mask_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import 'login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.lazyPut(() => LoginController(
          mask: Get.find<MaskAdapter>(),
          validator: Get.find<ValidatorAdapter>(),
        ));
  }
}
