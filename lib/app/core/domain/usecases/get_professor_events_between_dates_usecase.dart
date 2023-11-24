import '../../data/repositories/get_professor_events_between_dates_repository.dart';
import '../../utils/app_date_utils.dart';
import '../entities/event_entity.dart';

class GetProfessorEventsBetweenDatesUsecase {
  final GetProfessorEventsBetweenDatesRepository
      _getProfessorEventsBetweenDatesRepository;

  GetProfessorEventsBetweenDatesUsecase(
      this._getProfessorEventsBetweenDatesRepository);

  Future<List<EventEntity>> call({
    required int id,
    required DateTime start,
    required DateTime end,
  }) async {
    return await _getProfessorEventsBetweenDatesRepository(
      id: id,
      start: AppDateUtils.storageDateFormat.format(start),
      end: AppDateUtils.storageDateFormat.format(end),
    );
  }
}
