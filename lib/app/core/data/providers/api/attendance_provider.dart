import 'dart:ffi';

import 'package:intl/intl.dart';

import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/attendance_entity.dart';
import '../../dtos/attendance_dto.dart';
import '../base_provider.dart';

class AttendanceProvider extends BaseProvider {
  Http http;

  AttendanceProvider({required this.http});

  Future<AttendanceEntity?> createAttendance(
      AttendanceEntity attendanceEntity) async {
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

      return AttendanceDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<AttendanceEntity?> fetchAttendanceFromClassroom(
      Long classroomId) async {
    try {
      final response = await http.get(
        '/attendance/classroom/$classroomId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return AttendanceDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<List<AttendanceEntity>?> fetchAttendancesByDate(
      Long classroomId, DateTime date) async {
    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);

      final response = await http.get(
        '/attendance/inClassroomByDate?classroomid=$classroomId&date=$formattedDate',
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
      return null;
    }
  }

  Future<List<AttendanceEntity>?> fetchAttendancesHappeningByClassroom(
      Long classroomId) async {
    try {
      final response = await http.get(
        '/attendance/allHappeningByClassroom/$classroomId',
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
      return null;
    }
  }

  Future<List<AttendanceEntity>?> fetchAttendancesHappeningByStudent(
      Long studentId) async {
    try {
      final response = await http.get(
        '/attendance/HappeningByStudent/$studentId',
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
      return null;
    }
  }
}
