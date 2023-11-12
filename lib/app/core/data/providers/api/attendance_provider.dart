import 'dart:core';

import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/attendance_entity.dart';
import '../../../utils/app_date_utils.dart';
import '../../dtos/attendance_dto.dart';
import '../base_provider.dart';

class AttendanceProvider extends BaseProvider {
  Http http;

  AttendanceProvider({required this.http});

  Future<AttendanceEntity?> create(AttendanceEntity attendanceEntity) async {
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

  Future<AttendanceEntity?> fetchByClassroomId(int classroomId) async {
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

  Future<List<AttendanceEntity>?> fetchByClassroomIdAndDate(
      int classroomId, DateTime date) async {
    try {
      String formattedDate = AppDateUtils.storageDateFormat.format(date);

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

  Future<List<AttendanceEntity>?> fetchHappeningByClassroomId(
      int classroomId) async {
    try {
      final response = await http.get(
        '/attendance/happeningByClassroom/$classroomId',
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

  Future<List<AttendanceEntity>?> fetchHappeningByStudentId(
      int studentId) async {
    try {
      final response = await http.get(
        '/attendance/happeningByStudent/$studentId',
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

  Future<AttendanceEntity?> update(AttendanceEntity attendanceEntity) async {
    try {
      AttendanceDto attendanceDto = AttendanceDto.fromEntity(attendanceEntity);

      final response = await http.put(
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
}
