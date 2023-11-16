import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/attendance_status_entity.dart';
import '../../dtos/attendance_status_dto.dart';
import '../base_provider.dart';

class AttendanceStatusProvider extends BaseProvider {
  Http http;

  AttendanceStatusProvider({required this.http});

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
        statusCodes: [200],
      );

      return AttendanceStatusDto.fromMap(response.data);
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
        statusCodes: [200],
      );

      return AttendanceStatusDto.fromMap(response.data);
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
        statusCodes: [200],
      );

      return AttendanceStatusDto.fromMap(response.data);
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
        statusCodes: [200],
      );

      final attendanceStatus = response.data
          .map<AttendanceStatusDto>(
            (attendanceStatus) => AttendanceStatusDto.fromMap(attendanceStatus),
          )
          .toList();

      return attendanceStatus;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<AttendanceStatusEntity?> fetchByAttendanceAndStudent(
      int studentId, int attendanceId) async {
    try {
      final response = await http.get(
        '/attendanceStatus/byAttendanceAndStudent?attendanceid=$attendanceId&studentid=$studentId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return AttendanceStatusDto.fromMap(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }
}
