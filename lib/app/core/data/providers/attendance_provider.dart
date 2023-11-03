import 'dart:ffi';

import '../../adapters/http_adapter.dart';
import '../../domain/entities/attendance_entity.dart';
import '../dtos/attendance_dto.dart';
import 'base_provider.dart';

class AttendanceProvider extends BaseProvider {
  Http http;

  AttendanceProvider({required this.http});

  Future<List<AttendanceDto>> fetchStudentAttendances(Long id) async {
    try {
      final response = await http.get(
        '/attendance/HappeningByStudent/$id',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final attendances = response.data
          .map<AttendanceDto>(
            (attendance) => AttendanceDto.fromJson(attendance),
          )
          .toList();

      return attendances;
    } catch (e) {
      logError(e.toString());
    }

    return [];
  }

  Future<List<AttendanceDto>> fetchClassAttendances(Long id) async {
    try {
      final response = await http.get(
        '/attendance/allHappeningByClassroom/$id',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final attendances = response.data
          .map<AttendanceDto>(
            (attendance) => AttendanceDto.fromJson(attendance),
          )
          .toList();

      return attendances;
    } catch (e) {
      logError(e.toString());
    }

    return [];
  }

  Future<void> createAttendance(AttendanceEntity attendanceEntity) async {
    try {
      AttendanceDto attendanceDto = AttendanceDto.fromEntity(attendanceEntity);

      final response = await http.post(
        '/attendance',
        body: attendanceDto.toJson(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );
    } catch (e) {
      logError(e.toString());
    }
  }
}
