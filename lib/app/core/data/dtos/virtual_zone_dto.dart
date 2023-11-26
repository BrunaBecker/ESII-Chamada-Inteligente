import 'dart:convert';

import '../../domain/entities/virtual_zone_entity.dart';
import 'location_dto.dart';

class VirtualZoneDto extends VirtualZoneEntity {
  VirtualZoneDto({
    super.id,
    required super.location,
  });

  factory VirtualZoneDto.fromEntity(VirtualZoneEntity entity) {
    return VirtualZoneDto(
      id: entity.id,
      location: entity.location,
    );
  }

  factory VirtualZoneDto.fromMap(Map<String, dynamic> map) {
    return VirtualZoneDto(
      id: map["id"],
      location: LocationDto.fromMap(map["location"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "location": LocationDto.fromEntity(location).toMap(),
    };
  }

  factory VirtualZoneDto.fromJson(String source) =>
      VirtualZoneDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
