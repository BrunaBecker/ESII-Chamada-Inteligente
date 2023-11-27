import '../../domain/entities/event_entity.dart';
import '../providers/api/event_provider.dart';

class CreateEventRepository {
  CreateEventRepository({
    required eventProvider,
  }) : _eventProvider = eventProvider;

  final EventProvider _eventProvider;

  Future<EventEntity> call({
    required EventEntity event,
  }) async {
    return await _eventProvider.create(event);
  }
}
