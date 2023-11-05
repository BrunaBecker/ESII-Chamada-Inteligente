import 'dart:convert';

import 'coordinate_entity.dart';

class CoordinateDto extends CoordinateEntity {
  CoordinateDto({
    required super.id,
    required super.latitude,
    required super.longitude,
  });

  factory CoordinateDto.fromEntity(CoordinateEntity entity) {
    return CoordinateDto(
      id: entity.id,
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }

  factory CoordinateDto.fromMap(Map<String, dynamic> map) {
    return CoordinateDto(
      id: map["id"],
      latitude: map["latitude"],
      longitude: map["longitude"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  factory CoordinateDto.fromJson(String source) => CoordinateDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
