import '../../domain/entities/notification_entity.dart';
import '../providers/api/notification_provider.dart';

class GetPersonNotificationsRepository {
  GetPersonNotificationsRepository({
    required notificationProvider,
  }) : _notificationProvider = notificationProvider;

  final NotificationProvider _notificationProvider;

  Future<List<NotificationEntity>?> call(int personId) async {
    return await _notificationProvider.fetchActivesByPersonId(personId);
  }
}
