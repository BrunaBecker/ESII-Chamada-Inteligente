import 'dart:convert';

import '../../domain/entities/course_entity.dart';

class CourseDto extends CourseEntity {
  CourseDto({
    required super.id,
    required super.code,
    required super.name,
  });

  factory CourseDto.fromEntity(CourseEntity entity) {
    return CourseDto(
      id: entity.id,
      code: entity.code,
      name: entity.name,
    );
  }

  factory CourseDto.fromMap(Map<String, dynamic> map) {
    return CourseDto(
      id: map["id"],
      code: map["code"],
      name: map["name"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "code": code,
      "name": name,
    };
  }

  factory CourseDto.fromJson(String source) =>
      CourseDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
