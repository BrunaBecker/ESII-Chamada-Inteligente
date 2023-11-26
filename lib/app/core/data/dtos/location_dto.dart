import 'dart:convert';

import '../../domain/entities/location_entity.dart';
import 'classroom_dto.dart';
import 'coordinate_dto.dart';
import 'professor_dto.dart';

class LocationDto extends LocationEntity {
  LocationDto({
    super.id,
    required super.title,
    required super.description,
    super.isActive = true,
    super.coordinate,
    super.professor,
    super.classroom,
  });

  factory LocationDto.fromEntity(LocationEntity entity) {
    return LocationDto(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isActive: entity.isActive,
      coordinate: entity.coordinate,
      professor: entity.professor,
      classroom: entity.classroom,
    );
  }

  factory LocationDto.fromMap(Map<String, dynamic> map) {
    // Check non required fields
    CoordinateDto? coordinate;
    if (map["coordinate"] != null) {
      coordinate = CoordinateDto.fromMap(map["coordinate"]);
    }

    ProfessorDto? professor;
    if (map["professor"] != null) {
      professor = ProfessorDto.fromMap(map["professor"]);
    }

    ClassroomDto? classroom;
    if (map["classroom"] != null) {
      classroom = ClassroomDto.fromMap(map["classroom"]);
    }

    return LocationDto(
      id: map["id"],
      title: map["title"],
      description: map["description"],
      isActive: map["active"],
      coordinate: coordinate,
      professor: professor,
      classroom: classroom,
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping Coordinate
    Map<String, dynamic>? coordinateAsMap;
    if (coordinate != null) {
      coordinateAsMap = CoordinateDto.fromEntity(coordinate!).toMap();
    }

    // Mapping Professor
    Map<String, dynamic>? professorAsMap;
    if (professor != null) {
      professorAsMap = ProfessorDto.fromEntity(professor!).toMap();
    }

    // Mapping Classroom
    Map<String, dynamic>? classroomAsMap;
    if (classroom != null) {
      classroomAsMap = ClassroomDto.fromEntity(classroom!).toMap();
    }

    return {
      "id": id,
      "title": title,
      "description": description,
      "active": isActive,
      "coordinate": coordinateAsMap,
      "professor": professorAsMap,
      "classroom": classroomAsMap,
    };
  }

  factory LocationDto.fromJson(String source) =>
      LocationDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
