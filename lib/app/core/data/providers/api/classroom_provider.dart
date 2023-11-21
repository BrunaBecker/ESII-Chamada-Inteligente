import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/attendance_entity.dart';
import '../../../domain/entities/classroom_entity.dart';
import '../../../domain/entities/event_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../../exceptions/unexpected_api_exception.dart';
import '../../dtos/attendance_dto.dart';
import '../../dtos/classroom_dto.dart';
import '../../dtos/event_dto.dart';
import '../base_provider.dart';

class ClassroomProvider extends BaseProvider {
  Http http;

  ClassroomProvider({required this.http});

  Future<List<ClassroomEntity>> fetchAll() async {
    try {
      final response = await http.get(
        '/classroom',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final classrooms = response.data
          .map<ClassroomDto>(
            (classroom) => ClassroomDto.fromMap(classroom),
          )
          .toList();

      return classrooms;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ClassroomEntity> create(ClassroomEntity classroomEntity) async {
    ClassroomDto classroomDto = ClassroomDto.fromEntity(classroomEntity);

    try {
      final response = await http.post(
        '/classroom',
        body: classroomDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [201],
      );

      return ClassroomDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ClassroomEntity> update(ClassroomEntity classroomEntity) async {
    ClassroomDto classroomDto = ClassroomDto.fromEntity(classroomEntity);

    try {
      final response = await http.put(
        '/classroom',
        body: classroomDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ClassroomDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<List<ClassroomEntity>> fetchByProfessorRegister(
      String professorIdentifier) async {
    try {
      final response = await http.get(
        '/classroom/professor/$professorIdentifier',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final classrooms = response.data
          .map<ClassroomDto>(
            (classroom) => ClassroomDto.fromMap(classroom),
          )
          .toList();

      return classrooms;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<List<ClassroomEntity>> fetchByStudentRegister(
      String studentIdentifier) async {
    try {
      final response = await http.get(
        '/classroom/student/$studentIdentifier',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final classrooms = response.data
          .map<ClassroomDto>(
            (classroom) => ClassroomDto.fromMap(classroom),
          )
          .toList();

      return classrooms;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ClassroomEntity> fetchById(int id) async {
    try {
      final response = await http.get(
        '/classroom/$id',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ClassroomDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ClassroomEntity> setStudent(int id, int studentId) async {
    try {
      final response = await http.put(
        '/classroom/setStudent',
        query: {
          'idClassroom': id,
          'idStudent': studentId,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ClassroomDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ClassroomEntity> removeStudent(int id, int studentId) async {
    try {
      final response = await http.put(
        '/classroom/removeStudent',
        query: {
          'idClassroom': id,
          'idStudent': studentId,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ClassroomDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ClassroomEntity> setEvent(int id, int eventId) async {
    try {
      final response = await http.put(
        '/classroom/setEvent',
        query: {
          'idClassroom': id,
          'idEvent': eventId,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ClassroomDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ClassroomEntity> removeEvent(int id, int eventId) async {
    try {
      final response = await http.put(
        '/classroom/removeEvent',
        query: {
          'idClassroom': id,
          'idEvent': eventId,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ClassroomDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ClassroomEntity> setLocation(int id, int locationId) async {
    try {
      final response = await http.put(
        '/classroom/setLocation',
        query: {
          'idClassroom': id,
          'idLocation': locationId,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ClassroomDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ClassroomEntity> setAttendance(int id, int idAttendance) async {
    try {
      final response = await http.put(
        '/classroom/setAttendance',
        query: {
          'idClassroom': id,
          'idAttendance': idAttendance,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ClassroomDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ClassroomEntity> addAttendance(
      int id, AttendanceEntity attendanceEntity) async {
    AttendanceDto attendanceDto = AttendanceDto.fromEntity(attendanceEntity);

    try {
      final response = await http.put(
        '/classroom/addAttendance',
        body: attendanceDto.toMap(),
        query: {
          'idClassroom': id,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ClassroomDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ClassroomEntity> addEvent(int id, EventEntity event) async {
    EventDto eventDto = EventDto.fromEntity(event);

    try {
      final response = await http.put(
        '/classroom/addEvent',
        body: eventDto.toMap(),
        query: {
          'idClassroom': id,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ClassroomDto.fromMap(response.data);
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }
}
