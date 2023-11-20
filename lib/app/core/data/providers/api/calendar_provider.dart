import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/calendar_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../dtos/calendar_dto.dart';
import '../base_provider.dart';

class CalendarProvider extends BaseProvider {
  Http http;

  CalendarProvider({required this.http});

  Future<CalendarEntity?> fetchById(int calendarId) async {
    try {
      final response = await http.get(
        '/calendar/$calendarId',
      );

      validateResponse(
        response: response,
      );

      return CalendarDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<CalendarEntity?> create(CalendarEntity calendarEntity) async {
    CalendarDto calendarDto = CalendarDto.fromEntity(calendarEntity);

    try {
      final response = await http.post(
        '/calendar',
        body: calendarDto.toJson(),
      );

      validateResponse(
        response: response,
      );

      return CalendarDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<CalendarEntity?> update(CalendarEntity calendarEntity) async {
    CalendarDto calendarDto = CalendarDto.fromEntity(calendarEntity);

    try {
      final response = await http.put(
        '/calendar',
        body: calendarDto.toJson(),
      );

      validateResponse(
        response: response,
      );

      return CalendarDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<CalendarEntity?> setEvent(int calendarId, int eventId) async {
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
      );

      return CalendarDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());

      return null;
    }
  }

  Future<CalendarEntity?> removeEvent(int calendarId, int eventId) async {
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
      );

      return CalendarDto.fromMap(response.data);
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
