import '../../data/repositories/get_person_notifications_repository.dart';
import '../entities/notification_entity.dart';

class GetPersonNotificationsUsecase {
  final GetPersonNotificationsRepository _personRepository;

  GetPersonNotificationsUsecase(this._personRepository);

  Future<List<NotificationEntity>?> call(int userId) async {
    return await _personRepository(userId);
  }
}
