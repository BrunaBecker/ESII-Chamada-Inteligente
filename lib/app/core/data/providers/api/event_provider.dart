import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/event_entity.dart';
import '../../dtos/event_dto.dart';
import '../base_provider.dart';

class EventProvider extends BaseProvider {
  Http http;

  EventProvider({required this.http});

  Future<EventEntity?> fetchAllEvents() async {
    try {
      final response = await http.get(
        '/event',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return EventDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  //TODO - Entender URL
  Future<EventDto?> fetchEventsByDatePeriod(
      DateTime startDate, DateTime endDate) async {
    try {
      final response = await http.get(
        '/event/byDateBetween/$startDate/endDate/$endDate',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return EventDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }
}
