import 'dart:ffi';

import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/attendance_status_entity.dart';
import '../../dtos/attendance_status_dto.dart';
import '../base_provider.dart';

class AttendanceStatusProvider extends BaseProvider {
  Http http;

  AttendanceStatusProvider({required this.http});

  Future<AttendanceStatusEntity?> createAttendanceStatus(
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

      return AttendanceStatusDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
    }
    return null;
  }

  Future<AttendanceStatusEntity?> updateAttendanceStatus(
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

      return AttendanceStatusDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
    }
    return null;
  }

  Future<AttendanceStatusEntity?> fetchAttendanceStatusByAttendanceId(
      Long attendanceStatusId) async {
    try {
      final response = await http.get(
        '/attendanceStatus/$attendanceStatusId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return AttendanceStatusDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<List<AttendanceStatusEntity>?> fetchAllAttendanceStatusFromAttendance(
      Long attendanceId) async {
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
            (attendanceStatus) =>
                AttendanceStatusDto.fromJson(attendanceStatus),
          )
          .toList();

      return attendanceStatus;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<AttendanceStatusEntity?> fetchStatusByAttendanceAndStudent(
      Long studentId, Long attendanceId) async {
    try {
      final response = await http.get(
        '/attendanceStatus/byAttendanceAndStudent?attendanceid=$attendanceId&studentid=$studentId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return AttendanceStatusDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }
}
