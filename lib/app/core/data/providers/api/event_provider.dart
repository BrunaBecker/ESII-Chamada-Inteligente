import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/event_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../../exceptions/unexpected_api_exception.dart';
import '../../dtos/event_dto.dart';
import '../base_provider.dart';

class EventProvider extends BaseProvider {
  Http http;

  EventProvider({required this.http});

  Future<List<EventEntity>> fetchAll() async {
    try {
      final response = await http.get(
        '/event',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final events = response.data
          .map<EventDto>(
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
      throw UnexpectedApiException();
    }
  }

  Future<EventEntity> create(EventEntity eventEntity) async {
    EventDto eventDto = EventDto.fromEntity(eventEntity);

    try {
      final response = await http.post(
        '/event',
        body: eventDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [201],
      );

      return EventDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<EventEntity> update(EventEntity eventEntity) async {
    EventDto eventDto = EventDto.fromEntity(eventEntity);

    try {
      final response = await http.put(
        '/event',
        body: eventDto.toMap(),
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
      throw UnexpectedApiException();
    }
  }

  Future<List<EventEntity>> fetchAllBetweenDates(
      String startDate, String endDate) async {
    try {
      final response = await http.get(
        '/event/byDateBetween',
        query: {
          'startDate': startDate,
          'endDate': endDate,
        },
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
      throw UnexpectedApiException();
    }
  }

  Future<List<EventEntity>> fetchAllBetweenDatesAndClassroomId(
    String startDate,
    String endDate,
    int classroomId,
  ) async {
    try {
      final response = await http.get(
        '/event/byDateBetweenAndClassroomId',
        query: {
          'startDate': startDate,
          'endDate': endDate,
          'classroomId': classroomId,
        },
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
      throw UnexpectedApiException();
    }
  }

  Future<List<EventEntity>> fetchAllByClassroomId(int classroomId) async {
    try {
      final response = await http.get(
        '/event/byClassroomId',
        query: {
          'classroomId': classroomId,
        },
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
      throw UnexpectedApiException();
    }
  }

  Future<List<EventEntity>> fetchAllBetweenDatesAndStudentId(
    int studentId,
    String startDate,
    String endDate,
  ) async {
    try {
      final response = await http.get(
        '/event/byDateBetweenAndStudentId',
        query: {
          'startDate': startDate,
          'endDate': endDate,
          'studentId': studentId,
        },
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
      throw UnexpectedApiException();
    }
  }

  Future<List<EventEntity>> fetchAllBetweenDatesAndProfessorId(
    int professorId,
    String startDate,
    String endDate,
  ) async {
    try {
      final response = await http.get(
        '/event/byDateBetweenAndProfessorId',
        query: {
          'startDate': startDate,
          'endDate': endDate,
          'professorId': professorId,
        },
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
      throw UnexpectedApiException();
    }
  }
}
