import 'package:get/get.dart';

import 'app_controller.dart';
import 'core/adapters/http_adapter.dart';
import 'core/adapters/location_adapter.dart';
import 'core/adapters/mask_adapter.dart';
import 'core/adapters/storage_adapter.dart';
import 'core/adapters/validator_adapter.dart';
import 'core/data/providers/api/notification_provider.dart';
import 'core/data/repositories/delete_person_notification_repository.dart';
import 'core/data/repositories/get_person_notifications_repository.dart';
import 'core/data/repositories/update_person_notification_repository.dart';
import 'core/domain/usecases/delete_person_notification_usecase.dart';
import 'core/domain/usecases/get_person_notifications_usecase.dart';
import 'core/domain/usecases/update_person_notification_usecase.dart';
import 'core/enums/mask.dart';
import 'pages/notifications/notifications_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Adapters
    Get.put<Http>(
      HttpAdapter(),
    );
    Get.put<MaskAdapter>(
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
    Get.put<ValidatorAdapter>(
      ValidatorAdapter(),
    );
    Get.put<LocationAdapter>(
      LocationAdapter(),
    );
    Get.put<StorageAdapter>(
      StorageAdapter.getInstance(),
    );

    // Providers
    Get.put<NotificationProvider>(
      NotificationProvider(
        http: Get.find<Http>(),
      ),
    );

    // Get Person Notifications
    Get.put<GetPersonNotificationsRepository>(
      GetPersonNotificationsRepository(
        notificationProvider: Get.find<NotificationProvider>(),
      ),
    );
    Get.put<GetPersonNotificationsUsecase>(
      GetPersonNotificationsUsecase(
        Get.find<GetPersonNotificationsRepository>(),
      ),
    );
    // Read Person Notification
    Get.put<UpdatePersonNotificationRepository>(
      UpdatePersonNotificationRepository(
        notificationProvider: Get.find<NotificationProvider>(),
      ),
    );
    Get.put<UpdatePersonNotificationUsecase>(
      UpdatePersonNotificationUsecase(
        Get.find<UpdatePersonNotificationRepository>(),
      ),
    );
    // Delete Person Notification
    Get.put<DeletePersonNotificationRepository>(
      DeletePersonNotificationRepository(
        notificationProvider: Get.find<NotificationProvider>(),
      ),
    );
    Get.put<DeletePersonNotificationUsecase>(
      DeletePersonNotificationUsecase(
        Get.find<DeletePersonNotificationRepository>(),
      ),
    );

    // Controllers
    Get.put<NotificationsController>(
      NotificationsController(
        getPersonNotifications: Get.find<GetPersonNotificationsUsecase>(),
        updatePersonNotification: Get.find<UpdatePersonNotificationUsecase>(),
        deletePersonNotification: Get.find<DeletePersonNotificationUsecase>(),
      ),
    );
    Get.put<AppController>(
      AppController(),
    );
  }
}
