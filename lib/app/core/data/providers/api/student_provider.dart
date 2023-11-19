import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/classroom_entity.dart';
import '../../../domain/entities/student_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../dtos/classroom_dto.dart';
import '../../dtos/student_dto.dart';
import '../base_provider.dart';

class StudentProvider extends BaseProvider {
  Http http;

  StudentProvider({required this.http});

  Future<StudentEntity?> createStudent(StudentEntity studentEntity) async {
    StudentDto studentDto = StudentDto.fromEntity(studentEntity);
    try {
      final response = await http.post(
        '/student',
        body: studentDto.toJson(),
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
      return null;
    }
  }

  Future<StudentEntity?> updateStudent(StudentEntity studentEntity) async {
    StudentDto studentDto = StudentDto.fromEntity(studentEntity);
    try {
      final response = await http.put(
        '/student',
        body: studentDto.toJson(),
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
      return null;
    }
  }

  Future<StudentEntity?> addClassroom(
      int studentIdentifier, ClassroomEntity classroomEntity) async {
    ClassroomDto classroomDto = ClassroomDto.fromEntity(classroomEntity);
    try {
      final response = await http.put(
        '/$studentIdentifier/class',
        body: classroomDto.toJson(),
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
      return null;
    }
  }

  Future<StudentEntity?> addClassroomByClassroomId(
      int studentIdenfitifer, int classroomId) async {
    try {
      final response = await http.put(
        '/$studentIdenfitifer/class/$classroomId',
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
      return null;
    }
  }

  Future<StudentEntity?> addAttendance(
      String studentIdentifier, int attendanceId) async {
    try {
      final response = await http.put(
        '/$studentIdentifier/attendance/$attendanceId',
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
      return null;
    }
  }

  Future<StudentEntity?> addWaiver(
      String studentIdentifier, int waiverId) async {
    try {
      final response = await http.put(
        '/$studentIdentifier/waiver/$waiverId',
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
      return null;
    }
  }

  Future<List<StudentEntity>?> fetchByClassroomId(int classroomId) async {
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
      return null;
    }
  }

  Future<List<StudentEntity>?> fetchByAttendanceId(int attendanceId) async {
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
      return null;
    }
  }

  Future<List<StudentDto>?> fetchByWaiverId(int waiverId) async {
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
      return null;
    }
  }

  Future<StudentEntity?> fetchById(int id) async {
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
      return null;
    }
  }

  Future<StudentEntity?> fetchByIdentifier(int studentIdentifier) async {
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
      return null;
    }
  }

  Future<List<StudentEntity>?> fetchByAttendanceHappeningId(
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
      return null;
    }
  }

  Future<StudentEntity?> fetchByEmail(String email) async {
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
      return null;
    }
  }

  Future<StudentEntity?> fetchByClassroomCode(String classroomCode) async {
    try {
      final response = await http.get(
        '/student/classroomCode/$classroomCode',
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
      return null;
    }
  }
}
