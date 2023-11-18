import '../../domain/entities/notification_entity.dart';
import '../providers/api/notification_provider.dart';

class UpdatePersonNotificationRepository {
  UpdatePersonNotificationRepository({
    required notificationProvider,
  }) : _notificationProvider = notificationProvider;

  final NotificationProvider _notificationProvider;

  Future<NotificationEntity?> call(NotificationEntity notification) async {
    return await _notificationProvider.update(notification);
  }
}
