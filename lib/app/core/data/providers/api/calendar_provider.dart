import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/calendar_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../../exceptions/unexpected_api_exception.dart';
import '../../dtos/calendar_dto.dart';
import '../base_provider.dart';

class CalendarProvider extends BaseProvider {
  Http http;

  CalendarProvider({required this.http});

  Future<CalendarEntity> fetchById() async {
    try {
      final response = await http.get(
        '/calendar',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return CalendarDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<CalendarEntity> update(CalendarEntity calendarEntity) async {
    CalendarDto calendarDto = CalendarDto.fromEntity(calendarEntity);

    try {
      final response = await http.put(
        '/calendar',
        body: calendarDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return CalendarDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<CalendarEntity> setEvent(int calendarId, int eventId) async {
    try {
      final response = await http.put(
        '/calendar/setEvent',
        query: {
          'idCalendar': calendarId,
          'idEvent': eventId,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return CalendarDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<CalendarEntity> removeEvent(int calendarId, int eventId) async {
    try {
      final response = await http.put(
        '/calendar/removeEvent',
        query: {
          'idCalendar': calendarId,
          'idEvent': eventId,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return CalendarDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }
}
