import 'dart:convert';

import '../../domain/entities/virtual_zone_entity.dart';

class VirtualZoneDto extends VirtualZoneEntity {
  VirtualZoneDto({
    super.id,
    required super.locationId,
    required super.attendanceId,
  });

  factory VirtualZoneDto.fromEntity(VirtualZoneEntity entity) {
    return VirtualZoneDto(
      id: entity.id,
      locationId: entity.locationId,
      attendanceId: entity.attendanceId,
    );
  }

  factory VirtualZoneDto.fromMap(Map<String, dynamic> map) {
    return VirtualZoneDto(
      id: map["id"],
      locationId: map["locationId"],
      attendanceId: map["attendanceId"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "locationId": locationId,
      "attendanceId": attendanceId,
    };
  }

  factory VirtualZoneDto.fromJson(String source) =>
      VirtualZoneDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
