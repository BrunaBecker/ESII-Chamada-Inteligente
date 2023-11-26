import 'dart:convert';

import '../../domain/entities/attendance_status_entity.dart';
import '../../enums/student_at_attendance_state.dart';
import 'attendance_dto.dart';
import 'student_dto.dart';

class AttendanceStatusDto extends AttendanceStatusEntity {
  AttendanceStatusDto({
    super.id,
    required super.studentState,
    super.studentHasResponded = false,
    super.validated = false,
    required super.student,
    required super.attendance,
  });

  factory AttendanceStatusDto.fromEntity(AttendanceStatusEntity entity) {
    return AttendanceStatusDto(
      id: entity.id,
      studentState: entity.studentState,
      studentHasResponded: entity.studentHasResponded,
      validated: entity.validated,
      student: entity.student,
      attendance: entity.attendance,
    );
  }

  factory AttendanceStatusDto.fromMap(Map<String, dynamic> map) {
    return AttendanceStatusDto(
      id: map["id"],
      studentState: StudentAtAttendanceState.fromText(map["studentState"]),
      studentHasResponded: map["studentHasResponded"],
      validated: map["validated"],
      student: StudentDto.fromMap(map["student"]),
      attendance: AttendanceDto.fromMap(map["attendance"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "studentState": studentState.toText(),
      "studentHasResponded": studentHasResponded,
      "validated": validated,
      "student": StudentDto.fromEntity(student).toMap(),
      "attendance": AttendanceDto.fromEntity(attendance).toMap(),
    };
  }

  factory AttendanceStatusDto.fromJson(String source) =>
      AttendanceStatusDto.fromMap(jsonDecode(source));

  String toJson() => toMap().toString();
}
