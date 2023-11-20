import 'dart:convert';

import '../../domain/entities/classroom_entity.dart';
import '../../utils/app_date_utils.dart';
import 'event_dto.dart';
import 'location_dto.dart';
import 'professor_dto.dart';
import 'student_dto.dart';

class ClassroomDto extends ClassroomEntity {
  ClassroomDto({
    super.id,
    required super.courseName,
    required super.className,
    required super.code,
    required super.semester,
    required super.startHour,
    required super.endHour,
    required super.professor,
    super.defaultLocation,
    super.events,
    super.students,
  });

  factory ClassroomDto.fromEntity(ClassroomEntity entity) {
    return ClassroomDto(
      id: entity.id,
      courseName: entity.courseName,
      className: entity.className,
      code: entity.code,
      semester: entity.semester,
      startHour: entity.startHour,
      endHour: entity.endHour,
      professor: entity.professor,
      defaultLocation: entity.defaultLocation,
      events: entity.events,
      students: entity.students,
    );
  }

  factory ClassroomDto.fromMap(Map<String, dynamic> map) {
    // Mapping Default Location
    LocationDto? defaultLocation;
    if (map["defaultLocation"] != null) {
      defaultLocation = LocationDto.fromMap(map["defaultLocation"]);
    }

    // Mapping Events
    List<EventDto> events = [];
    for (var eventMap in map["events"]) {
      events.add(EventDto.fromMap(eventMap));
    }

    List<StudentDto>? students = [];
    // Mapping Students
    if (map["students"] != null) {
      for (var studentMap in map["students"]) {
        students.add(StudentDto.fromMap(studentMap));
      }
    } else {
      students = null;
    }

    return ClassroomDto(
      id: map["id"],
      courseName: map["courseName"],
      className: map["className"],
      code: map["code"],
      semester: map["semester"],
      startHour: AppDateUtils.storageDateFormat.parse(map["startHour"]),
      endHour: AppDateUtils.storageDateFormat.parse(map["endHour"]),
      professor: ProfessorDto.fromMap(map["professor"]),
      defaultLocation: defaultLocation,
      events: events,
      students: students,
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping Default Location
    Map<String, dynamic>? defaultLocationAsMap;
    if (defaultLocation != null) {
      defaultLocationAsMap = LocationDto.fromEntity(defaultLocation!).toMap();
    }

    // Mapping Students
    List<Map<String, dynamic>> studentsAsMap = [];
    if (students != null) {
      for (var student in students!) {
        studentsAsMap.add(StudentDto.fromEntity(student).toMap());
      }
    }

    // Mapping Events
    List<Map<String, dynamic>> eventsAsMap = [];
    if (events != null) {
      for (var event in events!) {
        eventsAsMap.add(EventDto.fromEntity(event).toMap());
      }
    }

    return {
      "id": id,
      "courseName": courseName,
      "className": className,
      "code": code,
      "semester": semester,
      "startHour": AppDateUtils.storageDateFormat.format(startHour),
      "endHour": AppDateUtils.storageDateFormat.format(endHour),
      "professor": ProfessorDto.fromEntity(professor).toMap(),
      "defaultLocation": defaultLocationAsMap,
      "events": eventsAsMap,
      "students": studentsAsMap,
    };
  }

  factory ClassroomDto.fromJson(String json) =>
      ClassroomDto.fromMap(jsonDecode(json));

  String toJson() => jsonEncode(toMap());
}
