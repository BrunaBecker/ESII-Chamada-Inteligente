import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/domain/entities/notification_entity.dart';
import '../../core/domain/usecases/delete_person_notification_usecase.dart';
import '../../core/domain/usecases/get_person_notifications_usecase.dart';
import '../../core/domain/usecases/update_person_notification_usecase.dart';

class NotificationsController extends GetxController {
  NotificationsController({
    required GetPersonNotificationsUsecase getPersonNotifications,
    required UpdatePersonNotificationUsecase updatePersonNotification,
    required DeletePersonNotificationUsecase deletePersonNotification,
  })  : _getPersonNotifications = getPersonNotifications,
        _updatePersonNotification = updatePersonNotification,
        _deletePersonNotification = deletePersonNotification;

  final GetPersonNotificationsUsecase _getPersonNotifications;
  final UpdatePersonNotificationUsecase _updatePersonNotification;
  final DeletePersonNotificationUsecase _deletePersonNotification;
  final _isLoading = true.obs;
  final _notifications = <NotificationEntity>[].obs;

  bool get isLoading => _isLoading.value;
  List<NotificationEntity> get notifications => _notifications.toList();
  List<NotificationEntity> get unreadNotifications =>
      _notifications.where((element) => !element.isRead).toList();
  List<NotificationEntity> get readNotifications =>
      _notifications.where((element) => element.isRead).toList();
  int get totalUnreadNotifications => unreadNotifications.length;

  @override
  void onReady() {
    _isLoading.value = true;

    fetch();

    _isLoading.value = false;
    super.onReady();
  }

  void fetch() async {
    _isLoading.value = true;
    final appController = Get.find<AppController>();
    if (appController.userId == null) return;
    _notifications.clear();
    final newNotifications =
        await _getPersonNotifications(appController.userId!);
    if (newNotifications?.isNotEmpty ?? false) {
      _notifications.addAll(newNotifications!);
    }
    _isLoading.value = false;
  }

  void toggleReadNotification(int id) {
    final index = _notifications.indexWhere((element) => element.id == id);
    if (index != -1) {
      final notification = _notifications[index];
      notification.isRead = !notification.isRead;
      try {
        _updatePersonNotification(notification);
      } catch (_) {}
    }
    update();
  }

  void removeNotification(int id) {
    final index = _notifications.indexWhere((element) => element.id == id);
    if (index != -1) {
      final notification = _notifications[index]..isActive = false;
      _notifications.removeAt(index);
      try {
        _deletePersonNotification(notification.id);
      } catch (_) {}
    }
    update();
  }
}
