import 'dart:convert';

import '../../domain/entities/coordinate_dto.dart';
import '../../domain/entities/location_entity.dart';
import 'professor_dto.dart';
import 'virtual_zone_dto.dart';

class LocationDto extends LocationEntity {
  LocationDto({
    required super.id,
    required super.title,
    required super.description,
    required super.isActive,
    required super.coordinate,
    required super.professor,
    required super.virtualZones,
  });

  factory LocationDto.fromEntity(LocationEntity entity) {
    return LocationDto(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isActive: entity.isActive,
      coordinate: entity.coordinate,
      professor: entity.professor,
      virtualZones: entity.virtualZones,
    );
  }

  factory LocationDto.fromMap(Map<String, dynamic> map) {
    // Mapping VirtualZones
    List<VirtualZoneDto> virtualZones = [];
    for (var virtualZoneMap in map["virtualZones"]) {
      virtualZones.add(VirtualZoneDto.fromMap(virtualZoneMap));
    }

    return LocationDto(
      id: map["id"],
      title: map["title"],
      description: map["description"],
      isActive: map["isActive"],
      coordinate: CoordinateDto.fromMap(map["coordinate"]),
      professor: ProfessorDto.fromMap(map["professor"]),
      virtualZones: virtualZones,
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping VirtualZones
    List<Map<String, dynamic>> virtualZones = [];
    for (var virtualZone in this.virtualZones) {
      virtualZones.add(VirtualZoneDto.fromEntity(virtualZone).toMap());
    }

    return {
      "id": id,
      "title": title,
      "description": description,
      "isActive": isActive,
      "coordinate": CoordinateDto.fromEntity(coordinate).toMap(),
      "professor": ProfessorDto.fromEntity(professor).toMap(),
      "virtualZones": virtualZones,
    };
  }

  factory LocationDto.fromJson(String source) =>
      LocationDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
