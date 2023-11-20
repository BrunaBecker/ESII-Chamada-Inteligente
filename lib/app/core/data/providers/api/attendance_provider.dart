import 'dart:core';

import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/attendance_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../../utils/app_date_utils.dart';
import '../../dtos/attendance_dto.dart';
import '../base_provider.dart';

class AttendanceProvider extends BaseProvider {
  Http http;

  AttendanceProvider({required this.http});

  Future<List<AttendanceEntity>?> fetchAll() async {
    try {
      final response = await http.get(
        '/attendance',
      );

      validateResponse(
        response: response,
      );

      final attendances = response.data
          .map<AttendanceDto>(
            (attendance) => AttendanceDto.fromMap(attendance),
          )
          .toList();

      return attendances;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<AttendanceEntity?> create(AttendanceEntity attendanceEntity) async {
    try {
      AttendanceDto attendanceDto = AttendanceDto.fromEntity(attendanceEntity);

      final response = await http.post(
        '/attendance',
        body: attendanceDto.toJson(),
      );

      validateResponse(
        response: response,
      );

      return AttendanceDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
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
      );

      return AttendanceDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
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
      );

      final attendances = response.data
          .map<AttendanceDto>(
            (attendance) => AttendanceDto.fromMap(attendance),
          )
          .toList();

      return attendances;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<List<AttendanceEntity>?> fetchAllHappening() async {
    try {
      final response = await http.get(
        '/attendance/happening',
      );

      validateResponse(
        response: response,
      );

      final attendances = response.data
          .map<AttendanceDto>(
            (attendance) => AttendanceDto.fromMap(attendance),
          )
          .toList();

      return attendances;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
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
      );

      final attendances = response.data
          .map<AttendanceDto>(
            (attendance) => AttendanceDto.fromMap(attendance),
          )
          .toList();

      return attendances;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
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
      );

      final attendances = response.data
          .map<AttendanceDto>(
            (attendance) => AttendanceDto.fromMap(attendance),
          )
          .toList();

      return attendances;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<AttendanceEntity?> fetchById(int id) async {
    try {
      final response = await http.get(
        '/attendance/$id',
      );

      validateResponse(
        response: response,
      );

      return AttendanceDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
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
      );

      return AttendanceDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<AttendanceEntity?> start(int id) async {
    try {
      final response = await http.put(
        '/attendance/start/$id',
      );

      validateResponse(
        response: response,
      );

      return AttendanceDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<AttendanceEntity?> end(int id) async {
    try {
      final response = await http.put(
        '/attendance/end/$id',
      );

      validateResponse(
        response: response,
      );

      return AttendanceDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());

      return null;
    }
  }

  Future<AttendanceEntity?> setVirtualZone(int id, int virtualZoneId) async {
    try {
      final response = await http.put(
        '/attendance/setVirtualZone',
        query: {
          'idAttendance': id,
          'idVirtualZone': virtualZoneId,
        },
      );

      validateResponse(
        response: response,
      );

      return AttendanceDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logContent(e.toString());

      return null;
    }
  }

  Future<AttendanceEntity?> setAttendanceStatus(
      int id, int attendanceStatusId) async {
    try {
      final response = await http.put(
        '/attendance/setAttendanceStatus',
        query: {
          'idAttendance': id,
          'idAttendanceStatus': attendanceStatusId,
        },
      );

      validateResponse(
        response: response,
      );

      return AttendanceDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logContent(e.toString());

      return null;
    }
  }
}
