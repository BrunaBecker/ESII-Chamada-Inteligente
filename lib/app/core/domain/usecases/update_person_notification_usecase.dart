import '../../data/repositories/update_person_notification_repository.dart';
import '../entities/notification_entity.dart';

class UpdatePersonNotificationUsecase {
  final UpdatePersonNotificationRepository _personRepository;

  UpdatePersonNotificationUsecase(this._personRepository);

  Future<NotificationEntity?> call(NotificationEntity notification) async {
    return await _personRepository(notification);
  }
}
