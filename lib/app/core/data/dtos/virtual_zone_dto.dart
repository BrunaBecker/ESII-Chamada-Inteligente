import 'dart:convert';

import '../../domain/entities/virtual_zone_entity.dart';
import 'attendance_dto.dart';
import 'location_dto.dart';

class VirtualZoneDto extends VirtualZoneEntity {
  VirtualZoneDto({
    required super.id,
    required super.location,
    required super.attendance,
  });

  factory VirtualZoneDto.fromEntity(VirtualZoneEntity entity) {
    return VirtualZoneDto(
      id: entity.id,
      location: entity.location,
      attendance: entity.attendance,
    );
  }

  factory VirtualZoneDto.fromMap(Map<String, dynamic> map) {
    return VirtualZoneDto(
      id: map["id"],
      location: LocationDto.fromMap(map["location"]),
      attendance: AttendanceDto.fromMap(map["attendance"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "location": LocationDto.fromEntity(location).toMap(),
      "attendance": AttendanceDto.fromEntity(attendance).toMap(),
    };
  }

  factory VirtualZoneDto.fromJson(String source) =>
      VirtualZoneDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
