import 'dart:convert';

import '../../domain/entities/virtual_zone_entity.dart';

class VirtualZoneDto extends VirtualZoneEntity {
  VirtualZoneDto({
    super.id,
    required super.locationId,
  });

  factory VirtualZoneDto.fromEntity(VirtualZoneEntity entity) {
    return VirtualZoneDto(
      id: entity.id,
      locationId: entity.locationId,
    );
  }

  factory VirtualZoneDto.fromMap(Map<String, dynamic> map) {
    return VirtualZoneDto(
      id: map["id"],
      locationId: map["locationId"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "locationId": locationId,
    };
  }

  factory VirtualZoneDto.fromJson(String source) =>
      VirtualZoneDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
