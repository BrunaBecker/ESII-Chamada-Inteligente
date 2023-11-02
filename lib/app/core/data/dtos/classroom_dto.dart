import 'dart:convert';

import '../../domain/entities/classroom_entity.dart';
import 'attendance_dto.dart';
import 'location_dto.dart';
import 'professor_dto.dart';
import 'student_dto.dart';

class ClassroomDto extends ClassroomEntity {
  ClassroomDto({
    required super.id,
    required super.name,
    required super.code,
    required super.semester,
    required super.defaultLocation,
    required super.professor,
    required super.students,
    required super.attendances,
  });

  factory ClassroomDto.fromEntity(ClassroomEntity entity) {
    return ClassroomDto(
      id: entity.id,
      name: entity.name,
      code: entity.code,
      semester: entity.semester,
      defaultLocation: entity.defaultLocation,
      professor: entity.professor,
      students: entity.students,
      attendances: entity.attendances,
    );
  }

  factory ClassroomDto.fromMap(Map<String, dynamic> map) {
    // Mapping Students
    List<StudentDto> students = [];
    for (var studentMap in map["students"]) {
      students.add(StudentDto.fromMap(studentMap));
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
      defaultLocation: LocationDto.fromMap(map["defaultLocation"]),
      professor: ProfessorDto.fromMap(map["professor"]),
      students: students,
      attendances: attendances,
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping Students
    List<Map<String, dynamic>> studentsAsMap = [];
    for (var student in students) {
      studentsAsMap.add(StudentDto.fromEntity(student).toMap());
    }
    // Mapping Attendances
    List<Map<String, dynamic>> attendancesAsMap = [];
    for (var attendance in attendances) {
      attendancesAsMap.add(AttendanceDto.fromEntity(attendance).toMap());
    }

    return {
      "id": id,
      "name": name,
      "code": code,
      "semester": semester,
      "defaultLocation": LocationDto.fromEntity(defaultLocation).toMap(),
      "professor": ProfessorDto.fromEntity(professor).toMap(),
      "students": studentsAsMap,
      "attendances": attendancesAsMap,
    };
  }

  factory ClassroomDto.fromJson(String json) => ClassroomDto.fromMap(jsonDecode(json));

  String toJson() => jsonEncode(toMap());
}
