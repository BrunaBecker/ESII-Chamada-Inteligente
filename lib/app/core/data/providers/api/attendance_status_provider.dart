import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/attendance_status_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../dtos/attendance_status_dto.dart';
import '../base_provider.dart';

class AttendanceStatusProvider extends BaseProvider {
  Http http;

  AttendanceStatusProvider({required this.http});

  Future<List<AttendanceStatusEntity>?> fetchAll() async {
    try {
      final response = await http.get(
        '/attendanceStatus',
      );

      validateResponse(
        response: response,
      );

      final attendanceStatus = response.data
          .map<AttendanceStatusDto>(
            (attendanceStatus) => AttendanceStatusDto.fromMap(attendanceStatus),
          )
          .toList();

      return attendanceStatus;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<AttendanceStatusEntity?> create(
      AttendanceStatusEntity attendanceStatusEntity) async {
    AttendanceStatusDto attendanceStatusDto =
        AttendanceStatusDto.fromEntity(attendanceStatusEntity);

    try {
      final response = await http.post(
        '/attendanceStatus',
        body: attendanceStatusDto.toJson(),
      );

      validateResponse(
        response: response,
      );

      return AttendanceStatusDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
    }
    return null;
  }

  Future<AttendanceStatusEntity?> update(
      AttendanceStatusEntity attendanceStatusEntity) async {
    AttendanceStatusDto attendanceStatusDto =
        AttendanceStatusDto.fromEntity(attendanceStatusEntity);

    try {
      final response = await http.put(
        '/attendanceStatus',
        body: attendanceStatusDto.toJson(),
      );

      validateResponse(
        response: response,
      );

      return AttendanceStatusDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
    }
    return null;
  }

  Future<AttendanceStatusEntity?> fetchById(int attendanceStatusId) async {
    try {
      final response = await http.get(
        '/attendanceStatus/$attendanceStatusId',
      );

      validateResponse(
        response: response,
      );

      return AttendanceStatusDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<List<AttendanceStatusEntity>?> fetchAllByAttendanceId(
      int attendanceId) async {
    try {
      final response = await http.get(
        '/attendanceStatus/attendance/$attendanceId',
      );

      validateResponse(
        response: response,
      );

      final attendanceStatus = response.data
          .map<AttendanceStatusDto>(
            (attendanceStatus) => AttendanceStatusDto.fromMap(attendanceStatus),
          )
          .toList();

      return attendanceStatus;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<AttendanceStatusEntity?> fetchByAttendanceAndStudent(
      int studentId, int attendanceId) async {
    try {
      final response =
          await http.get('/attendanceStatus/byAttendanceAndStudent', query: {
        'attendanceid': attendanceId,
        'studentid': studentId,
      });

      validateResponse(
        response: response,
      );

      return AttendanceStatusDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<AttendanceStatusEntity?> invalidate(int id) async {
    try {
      final response = await http.put(
        '/attendanceStatus/invalidate/$id',
      );

      validateResponse(
        response: response,
      );

      return AttendanceStatusDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
    }
    return null;
  }

  Future<AttendanceStatusEntity?> respond(int id) async {
    try {
      final response = await http.put(
        '/attendanceStatus/respond/$id',
      );

      validateResponse(
        response: response,
      );

      return AttendanceStatusDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
    }
    return null;
  }

  Future<AttendanceStatusEntity?> setWaiver(int id, int waiverId) async {
    try {
      final response = await http.put(
        '/attendanceStatus/setWaiver',
        query: {
          'idAttendanceStatus': id,
          'idWaiver': waiverId,
        },
      );

      validateResponse(
        response: response,
      );

      return AttendanceStatusDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
    }
    return null;
  }

  Future<AttendanceStatusEntity?> setSuccessfulPing(int id, int pingId) async {
    try {
      final response = await http.put(
        '/attendanceStatus/setSuccessfulPing',
        query: {
          'idAttendanceStatus': id,
          'idPing': pingId,
        },
      );

      validateResponse(
        response: response,
      );

      return AttendanceStatusDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());

      return null;
    }
  }

  Future<AttendanceStatusEntity?> setUnsuccessfulPing(
      int id, int pingId) async {
    try {
      final response = await http.put(
        '/attendanceStatus/setUnsuccessfulPing',
        query: {
          'idAttendanceStatus': id,
          'idPing': pingId,
        },
      );

      validateResponse(
        response: response,
      );

      return AttendanceStatusDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());

      return null;
    }
  }

  Future<AttendanceStatusEntity?> removeSuccessfulPing(
      int id, int pingId) async {
    try {
      final response = await http.put(
        '/attendanceStatus/removeSuccessfulPing',
        query: {
          'idAttendanceStatus': id,
          'idPing': pingId,
        },
      );

      validateResponse(
        response: response,
      );

      return AttendanceStatusDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());

      return null;
    }
  }

  Future<AttendanceStatusEntity?> removeUnsuccessfulPing(
      int id, int pingId) async {
    try {
      final response = await http.put(
        '/attendanceStatus/removeUnsuccessfulPing',
        query: {
          'idAttendanceStatus': id,
          'idPing': pingId,
        },
      );

      validateResponse(
        response: response,
      );

      return AttendanceStatusDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    }
  }

  Future<List<AttendanceStatusEntity>?> fetchAllByStudentId(
      int studentId) async {
    try {
      final response = await http.get(
        '/attendanceStatus/byStudent',
        query: {
          'idStudent': studentId,
        },
      );

      validateResponse(
        response: response,
      );

      final attendanceStatus = response.data
          .map<AttendanceStatusDto>(
            (attendanceStatus) => AttendanceStatusDto.fromMap(attendanceStatus),
          )
          .toList();

      return attendanceStatus;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    }
  }
}
