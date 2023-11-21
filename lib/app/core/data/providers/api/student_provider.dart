import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/attendance_status_entity.dart';
import '../../../domain/entities/classroom_entity.dart';
import '../../../domain/entities/student_entity.dart';
import '../../../domain/entities/waiver_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../../exceptions/unexpected_api_exception.dart';
import '../../dtos/attendance_status_dto.dart';
import '../../dtos/classroom_dto.dart';
import '../../dtos/student_dto.dart';
import '../../dtos/waiver_dto.dart';
import '../base_provider.dart';

class StudentProvider extends BaseProvider {
  Http http;

  StudentProvider({required this.http});

  Future<StudentEntity> createStudent(StudentEntity studentEntity) async {
    StudentDto studentDto = StudentDto.fromEntity(studentEntity);
    try {
      final response = await http.post(
        '/student',
        body: studentDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [201],
      );

      return StudentDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<StudentEntity> updateStudent(StudentEntity studentEntity) async {
    StudentDto studentDto = StudentDto.fromEntity(studentEntity);
    try {
      final response = await http.put(
        '/student',
        body: studentDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return StudentDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<StudentEntity> addClassroom(
      int id, ClassroomEntity classroomEntity) async {
    ClassroomDto classroomDto = ClassroomDto.fromEntity(classroomEntity);
    try {
      final response = await http.put(
        '/student/addClassroom',
        query: {
          'id': id,
        },
        body: classroomDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return StudentDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<StudentEntity> setClassroom(int id, int classroomId) async {
    try {
      final response = await http.put(
        '/student/setClassroom',
        query: {
          'id': id,
          'idClassroom': classroomId,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return StudentDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<StudentEntity> setAttendanceStatus(
      int id, int attendanceStatusId) async {
    try {
      final response = await http.put(
        '/student/setAttendanceStatus',
        query: {
          'id': id,
          'idAttendanceStatus': attendanceStatusId,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return StudentDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<StudentEntity> addAttendanceStatus(
      int id, AttendanceStatusEntity attendanceStatusEntity) async {
    AttendanceStatusDto attendanceStatusDto =
        AttendanceStatusDto.fromEntity(attendanceStatusEntity);

    try {
      final response = await http.put(
        '/student/addAttendanceStatus',
        query: {
          'id': id,
        },
        body: attendanceStatusDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return StudentDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<StudentEntity> setWaiver(int id, int waiverId) async {
    try {
      final response = await http.put(
        '/student/setWaiver',
        query: {
          'id': id,
          'idWaiver': waiverId,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return StudentDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<StudentEntity> addWaiver(int id, WaiverEntity waiverEntity) async {
    WaiverDto waiverDto = WaiverDto.fromEntity(waiverEntity);

    try {
      final response = await http.put(
        '/student/addWaiver',
        query: {
          'id': id,
        },
        body: waiverDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return StudentDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<List<StudentEntity>> fetchByClassroomId(int classroomId) async {
    try {
      final response = await http.get(
        '/student/classroom/$classroomId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final students = response.data
          .map<StudentDto>(
            (student) => StudentDto.fromMap(student),
          )
          .toList();

      return students;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<List<StudentEntity>> fetchByAttendanceId(int attendanceId) async {
    try {
      final response = await http.get(
        '/student/attendance/$attendanceId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final students = response.data
          .map<StudentDto>(
            (student) => StudentDto.fromMap(student),
          )
          .toList();

      return students;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<List<StudentDto>> fetchByWaiverId(int waiverId) async {
    try {
      final response = await http.get(
        '/student/waiver/$waiverId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final students = response.data
          .map<StudentDto>(
            (student) => StudentDto.fromMap(student),
          )
          .toList();

      return students;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<StudentEntity> fetchById(int id) async {
    try {
      final response = await http.get(
        '/student/$id',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return StudentDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<StudentEntity> fetchByIdentifier(int studentIdentifier) async {
    try {
      final response = await http.get(
        '/student/byIdentifier/$studentIdentifier',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return StudentDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<List<StudentEntity>> fetchByAttendanceHappeningId(
      int attendanceHappeningId) async {
    try {
      final response = await http.get(
        '/student/attendanceHappening/$attendanceHappeningId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final students = response.data
          .map<StudentDto>(
            (student) => StudentDto.fromMap(student),
          )
          .toList();

      return students;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<StudentEntity> fetchByEmail(String email) async {
    try {
      final response = await http.get(
        '/student/byEmail/$email',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return StudentDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<List<StudentEntity>> fetchAllByClassroomInfos(
      String code, String className, String semester) async {
    try {
      final response = await http.get(
        '/student/classroomByCodeClassNameSemester',
        query: {
          'code': code,
          'className': className,
          'semester': semester,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final students = response.data
          .map<StudentDto>(
            (student) => StudentDto.fromMap(student),
          )
          .toList();

      return students;
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
