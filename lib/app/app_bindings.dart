import 'package:get/get.dart';

import 'core/adapters/mask_adapter.dart';
import 'core/enums/mask.dart';
import 'pages/notifications/notifications_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Adapters
    Get.put(
      MaskAdapter(
        registration: Formatter(
          pattern: Mask.registration.pattern(),
          filters: Mask.registration.filters(),
        ),
        siape: Formatter(
          pattern: Mask.siape.pattern(),
          filters: Mask.siape.filters(),
        ),
        date: Formatter(
          pattern: Mask.date.pattern(),
          filters: Mask.date.filters(),
        ),
        time: Formatter(
          pattern: Mask.time.pattern(),
          filters: Mask.time.filters(),
        ),
      ),
    );

    // Controllers
    Get.put<NotificationsController>(NotificationsController());
  }
}
