import 'dart:convert';

import '../../domain/entities/attendance_status_entity.dart';
import 'attendance_dto.dart';
import 'ping_dto.dart';
import 'student_dto.dart';

class AttendanceStatusDto extends AttendanceStatusEntity {
  AttendanceStatusDto({
    required super.id,
    required super.studentState,
    required super.studentHasResponded,
    required super.validated,
    required super.student,
    required super.attendance,
    required super.successfulPings,
    required super.unsuccessfulPings,
  });

  factory AttendanceStatusDto.fromEntity(AttendanceStatusEntity entity) {
    return AttendanceStatusDto(
      id: entity.id,
      studentState: entity.studentState,
      studentHasResponded: entity.studentHasResponded,
      validated: entity.validated,
      student: entity.student,
      attendance: entity.attendance,
      successfulPings: entity.successfulPings,
      unsuccessfulPings: entity.unsuccessfulPings,
    );
  }

  factory AttendanceStatusDto.fromMap(Map<String, dynamic> map) {
    // Mapping Pings
    List<PingDto> successfulPings = [];
    for (var successfulPingMap in map["successfulPings"]) {
      successfulPings.add(PingDto.fromMap(successfulPingMap));
    }
    List<PingDto> unsuccessfulPings = [];
    for (var unsuccessfulPingMap in map["unsuccessfulPings"]) {
      unsuccessfulPings.add(PingDto.fromMap(unsuccessfulPingMap));
    }

    return AttendanceStatusDto(
      id: map["id"],
      studentState: map["studentState"],
      studentHasResponded: map["studentHasResponded"],
      validated: map["validated"],
      student: StudentDto.fromMap(map["student"]),
      attendance: AttendanceDto.fromMap(map["attendance"]),
      successfulPings: successfulPings,
      unsuccessfulPings: unsuccessfulPings,
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping Pings
    List<Map<String, dynamic>> successfulPingsAsMap = [];
    for (var successfulPing in successfulPings) {
      successfulPingsAsMap.add(PingDto.fromEntity(successfulPing).toMap());
    }
    List<Map<String, dynamic>> unsuccessfulPingsAsMap = [];
    for (var unsuccessfulPing in unsuccessfulPings) {
      unsuccessfulPingsAsMap.add(PingDto.fromEntity(unsuccessfulPing).toMap());
    }

    return {
      "id": id,
      "studentState": studentState,
      "studentHasResponded": studentHasResponded,
      "validated": validated,
      "student": StudentDto.fromEntity(student).toMap(),
      "attendance": AttendanceDto.fromEntity(attendance).toMap(),
      "successfulPings": successfulPingsAsMap,
      "unsuccessfulPings": unsuccessfulPingsAsMap,
    };
  }

  factory AttendanceStatusDto.fromJson(String source) =>
      AttendanceStatusDto.fromMap(jsonDecode(source));

  String toJson() => toMap().toString();
}
