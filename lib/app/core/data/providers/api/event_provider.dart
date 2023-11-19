import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/event_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../../utils/app_date_utils.dart';
import '../../dtos/event_dto.dart';
import '../base_provider.dart';

class EventProvider extends BaseProvider {
  Http http;

  EventProvider({required this.http});

  Future<EventEntity?> create(EventEntity eventEntity) async {
    EventDto eventDto = EventDto.fromEntity(eventEntity);

    try {
      final response = await http.post(
        '/event',
        body: eventDto.toJson(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return EventDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<EventEntity?> update(EventEntity eventEntity) async {
    EventDto eventDto = EventDto.fromEntity(eventEntity);

    try {
      final response = await http.put(
        '/event',
        body: eventDto.toJson(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return EventDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<List<EventEntity>?> fetchAllBetweenDates(
      DateTime startDate, DateTime endDate) async {
    try {
      String formattedStartDate =
          AppDateUtils.storageDateFormat.format(startDate);
      String formattedEndDate = AppDateUtils.storageDateFormat.format(endDate);

      final response = await http.get(
        '/event/byDateBetween?startDate=$formattedStartDate&endDate=$formattedEndDate',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      List<EventEntity> events = response.data
          .map<EventEntity>(
            (event) => EventDto.fromMap(event),
          )
          .toList();

      return events;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }
}
