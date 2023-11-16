import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/calendar_entity.dart';
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
        statusCodes: [200],
      );

      return CalendarDto.fromMap(response.data);
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
        statusCodes: [200],
      );

      return CalendarDto.fromMap(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<CalendarEntity> update(CalendarEntity calendarEntity) async {
    CalendarDto calendarDto = CalendarDto.fromEntity(calendarEntity);

    try {
      final response = await http.put(
        '/calendar',
        body: calendarDto.toJson(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return CalendarDto.fromMap(response.data);
    } catch (e) {
      logError(e.toString());
      return calendarEntity;
    }
  }
}
