import '../providers/api/notification_provider.dart';

class DeletePersonNotificationRepository {
  DeletePersonNotificationRepository({
    required notificationProvider,
  }) : _notificationProvider = notificationProvider;

  final NotificationProvider _notificationProvider;

  Future<bool> call(int id) async {
    return await _notificationProvider.deleteById(id);
  }
}
