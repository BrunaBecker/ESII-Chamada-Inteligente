import 'dart:ffi';

import '../../adapters/http_adapter.dart';
import '../../domain/entities/attendance_status_entity.dart';
import '../dtos/attendance_status_dto.dart';
import 'base_provider.dart';

class AttendanceStatusProvider extends BaseProvider {
  Http http;

  AttendanceStatusProvider({required this.http});

  Future<void> createAttendanceStatus(
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

      return response.data;
    } catch (e) {
      logError(e.toString());
    }
  }

  Future<void> updateAttendanceStatus(
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

      return response.data;
    } catch (e) {
      logError(e.toString());
    }
  }

  Future<AttendanceStatusDto?> fetchStatusByAttendanceAndStudent(
      Long studentId, Long attendanceId) async {
    try {
      final response = await http.get(
        '/attendanceStatus/byAttendanceAndStudent?attendanceid=$attendanceId&studentid=$studentId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final attendanceStatus = AttendanceStatusDto.fromJson(response.data);

      return attendanceStatus;
    } catch (e) {
      logError(e.toString());
    }

    return null;
  }
}
