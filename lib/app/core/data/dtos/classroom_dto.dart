import 'dart:convert';

import '../../domain/entities/classroom_entity.dart';
import '../../utils/app_date_utils.dart';
import 'attendance_dto.dart';
import 'professor_dto.dart';
import 'student_dto.dart';

class ClassroomDto extends ClassroomEntity {
  ClassroomDto({
    required super.id,
    required super.name,
    required super.code,
    required super.semester,
    required super.startHour,
    required super.endHour,
    required super.professor,
    super.students,
  });

  factory ClassroomDto.fromEntity(ClassroomEntity entity) {
    return ClassroomDto(
      id: entity.id,
      name: entity.name,
      code: entity.code,
      semester: entity.semester,
      startHour: entity.startHour,
      endHour: entity.endHour,
      professor: entity.professor,
      students: entity.students,
    );
  }

  factory ClassroomDto.fromMap(Map<String, dynamic> map) {
    List<StudentDto>? students = [];
    // Mapping Students
    if (map["students"] != null) {
      for (var studentMap in map["students"]) {
        students.add(StudentDto.fromMap(studentMap));
      }
    } else {
      students = null;
    }

    // Mapping Attendances
    List<AttendanceDto> attendances = [];
    for (var attendanceMap in map["attendances"]) {
      attendances.add(AttendanceDto.fromMap(attendanceMap));
    }

    return ClassroomDto(
      id: map["id"],
      name: map["name"],
      code: map["code"],
      semester: map["semester"],
      startHour: AppDateUtils.storageDateFormat.parse(map["startHour"]),
      endHour: AppDateUtils.storageDateFormat.parse(map["endHour"]),
      professor: ProfessorDto.fromMap(map["professor"]),
      students: students,
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping Students
    List<Map<String, dynamic>>? studentsAsMap;
    if (students != null) {
      List<Map<String, dynamic>> studentsAsMap = [];
      for (var student in students!) {
        studentsAsMap.add(StudentDto.fromEntity(student).toMap());
      }
    }

    return {
      "id": id,
      "name": name,
      "code": code,
      "semester": semester,
      "startHour": AppDateUtils.storageDateFormat.format(startHour),
      "endHour": AppDateUtils.storageDateFormat.format(endHour),
      "professor": ProfessorDto.fromEntity(professor).toMap(),
      "students": studentsAsMap,
    };
  }

  factory ClassroomDto.fromJson(String json) =>
      ClassroomDto.fromMap(jsonDecode(json));

  String toJson() => jsonEncode(toMap());
}
