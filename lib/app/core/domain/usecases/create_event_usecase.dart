import '../../data/repositories/create_event_repository.dart';
import '../entities/event_entity.dart';

class CreateEventUsecase {
  final CreateEventRepository _eventRepository;

  CreateEventUsecase(this._eventRepository);

  Future<EventEntity> call({
    required EventEntity event,
  }) async {
    return await _eventRepository(
      event: event,
    );
  }
}
