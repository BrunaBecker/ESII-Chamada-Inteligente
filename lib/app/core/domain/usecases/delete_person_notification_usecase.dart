import '../../data/repositories/delete_person_notification_repository.dart';

class DeletePersonNotificationUsecase {
  final DeletePersonNotificationRepository _personRepository;

  DeletePersonNotificationUsecase(this._personRepository);

  Future<bool> call(int userId) async {
    return await _personRepository(userId);
  }
}
