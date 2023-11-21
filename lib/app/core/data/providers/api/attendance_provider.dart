import 'dart:core';

import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/attendance_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../../exceptions/unexpected_api_exception.dart';
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
        statusCodes: [200],
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
      throw UnexpectedApiException();
    }
  }

  Future<AttendanceEntity?> create(AttendanceEntity attendanceEntity) async {
    try {
      AttendanceDto attendanceDto = AttendanceDto.fromEntity(attendanceEntity);

      final response = await http.post(
        '/attendance',
        body: attendanceDto.toMap(),
      );

      validateResponse(response: response, statusCodes: [201]);

      return AttendanceDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
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

      return AttendanceDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<List<AttendanceEntity>?> fetchByClassroomIdAndDate(
    int classroomId,
    String date,
  ) async {
    try {
      final response = await http.get(
        '/attendance/getClassroomByDate?',
        query: {
          'idClassroom': classroomId,
          'date': date,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
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
      throw UnexpectedApiException();
    }
  }

  Future<List<AttendanceEntity>?> fetchAllHappening() async {
    try {
      final response = await http.get(
        '/attendance/happening',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
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
      throw UnexpectedApiException();
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
      throw UnexpectedApiException();
    }
  }

  Future<List<AttendanceEntity>?> fetchHappeningByProfessorId(
      int professorId) async {
    try {
      final response = await http.get(
        '/attendance/happeningByProfessor/$professorId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
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
      logContent(e.toString());
      throw UnexpectedApiException();
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
      throw UnexpectedApiException();
    }
  }

  Future<AttendanceEntity?> fetchById(int id) async {
    try {
      final response = await http.get(
        '/attendance/$id',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return AttendanceDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<AttendanceEntity?> update(AttendanceEntity attendanceEntity) async {
    try {
      AttendanceDto attendanceDto = AttendanceDto.fromEntity(attendanceEntity);

      final response = await http.put(
        '/attendance',
        body: attendanceDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return AttendanceDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<AttendanceEntity?> startAttendance(int id) async {
    try {
      final response = await http.put(
        '/attendance/start/$id',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return AttendanceDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<AttendanceEntity?> endAttendance(int id) async {
    try {
      final response = await http.put(
        '/attendance/end/$id',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return AttendanceDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
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
        statusCodes: [200],
      );

      return AttendanceDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logContent(e.toString());
      throw UnexpectedApiException();
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
        statusCodes: [200],
      );

      return AttendanceDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logContent(e.toString());
      throw UnexpectedApiException();
    }
  }
}
