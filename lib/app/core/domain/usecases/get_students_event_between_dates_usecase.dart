import '../../data/repositories/get_student_events_between_dates_repository.dart';
import '../../utils/app_date_utils.dart';
import '../entities/event_entity.dart';

class GetStudentEventsBetweenDatesUsecase {
  final GetStudentEventsBetweenDatesRepository
      _getStudentEventsBetweenDatesRepository;

  GetStudentEventsBetweenDatesUsecase(
      this._getStudentEventsBetweenDatesRepository);

  Future<List<EventEntity>> call({
    required int id,
    required DateTime start,
    required DateTime end,
  }) async {
    return await _getStudentEventsBetweenDatesRepository(
      id: id,
      start: AppDateUtils.storageDateFormat.format(start),
      end: AppDateUtils.storageDateFormat.format(end),
    );
  }
}
