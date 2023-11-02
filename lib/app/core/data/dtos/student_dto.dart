import 'dart:convert';

import '../../domain/entities/student_entity.dart';
import 'attendance_dto.dart';
import 'classroom_dto.dart';
import 'register_student_dto.dart';
import 'waiver_dto.dart';

class StudentDto extends StudentEntity {
  StudentDto({
    required super.id,
    required super.name,
    required super.socialName,
    required super.birthDate,
    required super.isActive,
    required super.cpf,
    required super.email,
    required super.password,
    required super.setting,
    required super.registration,
    required super.classrooms,
    required super.waivers,
    required super.attendances,
  });

  factory StudentDto.fromEntity(StudentEntity entity) {
    return StudentDto(
      id: entity.id,
      name: entity.name,
      socialName: entity.socialName,
      birthDate: entity.birthDate,
      isActive: entity.isActive,
      cpf: entity.cpf,
      email: entity.email,
      password: entity.password,
      setting: entity.setting,
      registration: entity.registration,
      classrooms: entity.classrooms,
      waivers: entity.waivers,
      attendances: entity.attendances,
    );
  }

  factory StudentDto.fromMap(Map<String, dynamic> map) {
    // Mapping classrooms
    final List<ClassroomDto> classrooms = [];
    for (var classroom in map["classrooms"]) {
      classroom = ClassroomDto.fromMap(classroom);
    }
    // Mapping waivers
    final List<WaiverDto> waivers = [];
    for (var waiver in map["waivers"]) {
      waiver = WaiverDto.fromMap(waiver);
    }
    // Mapping attendances
    final List<AttendanceDto> attendances = [];
    for (var attendance in map["attendances"]) {
      attendance = AttendanceDto.fromMap(attendance);
    }

    return StudentDto(
      id: map["id"],
      name: map["name"],
      socialName: map["socialName"],
      birthDate: DateTime.parse(map["birthDate"]),
      isActive: map["isActive"],
      cpf: map["cpf"],
      email: map["email"],
      password: map["password"],
      setting: map["setting"],
      registration: RegisterStudentDto.fromMap(map["registration"]),
      classrooms: classrooms,
      waivers: waivers,
      attendances: attendances,
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping classrooms
    final List<Map<String, dynamic>> classroomsAsMap = [];
    for (var classroom in classrooms) {
      classroomsAsMap.add(ClassroomDto.fromEntity(classroom).toMap());
    }
    // Mapping waivers
    final List<Map<String, dynamic>> waiversAsMap = [];
    for (var waiver in waivers) {
      waiversAsMap.add(WaiverDto.fromEntity(waiver).toMap());
    }
    // Mapping attendances
    final List<Map<String, dynamic>> attendancesAsMap = [];
    for (var attendance in attendances) {
      attendancesAsMap.add(AttendanceDto.fromEntity(attendance).toMap());
    }

    return {
      "id": id,
      "name": name,
      "socialName": socialName,
      "birthDate": birthDate.toIso8601String(),
      "isActive": isActive,
      "cpf": cpf,
      "email": email,
      "password": password,
      "setting": setting,
      "registration": RegisterStudentDto.fromEntity(registration).toMap(),
      "classrooms": classroomsAsMap,
      "waivers": waiversAsMap,
      "attendances": attendancesAsMap,
    };
  }

  factory StudentDto.fromJson(String source) => StudentDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
