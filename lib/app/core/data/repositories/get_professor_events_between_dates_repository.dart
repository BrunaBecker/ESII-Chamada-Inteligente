import '../../domain/entities/event_entity.dart';
import '../providers/api/event_provider.dart';

class GetProfessorEventsBetweenDatesRepository {
  GetProfessorEventsBetweenDatesRepository({
    required EventProvider eventProvider,
  }) : _eventProvider = eventProvider;

  final EventProvider _eventProvider;

  Future<List<EventEntity>> call({
    required int id,
    required String start,
    required String end,
  }) async {
    return await _eventProvider.fetchAllBetweenDatesAndProfessorId(
      id,
      start,
      end,
    );
  }
}
