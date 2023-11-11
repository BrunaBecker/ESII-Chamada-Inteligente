import 'dart:convert';

import 'classroom_dto.dart';
import 'coordinate_dto.dart';
import '../../domain/entities/location_entity.dart';
import 'professor_dto.dart';
import 'virtual_zone_dto.dart';

class LocationDto extends LocationEntity {
  LocationDto(
      {required super.id,
      required super.title,
      required super.description,
      required super.isActive,
      super.coordinate,
      super.professor,
      super.virtualZones,
      super.classroom});

  factory LocationDto.fromEntity(LocationEntity entity) {
    return LocationDto(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isActive: entity.isActive,
      coordinate: entity.coordinate,
      professor: entity.professor,
      virtualZones: entity.virtualZones,
      classroom: entity.classroom,
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
      classroom: ClassroomDto.fromMap(map["classroom"]),
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping VirtualZones
    List<Map<String, dynamic>> mappedVirtualZones = [];
    if (virtualZones != null) {
      for (var virtualZone in virtualZones!) {
        mappedVirtualZones.add(VirtualZoneDto.fromEntity(virtualZone).toMap());
      }
    }

    return {
      "id": id,
      "title": title,
      "description": description,
      "isActive": isActive,
      "coordinate": coordinate != null
          ? CoordinateDto.fromEntity(coordinate!).toMap()
          : null,
      "professor": professor != null
          ? ProfessorDto.fromEntity(professor!).toMap()
          : null,
      "virtualZones": virtualZones != null ? mappedVirtualZones : null,
      "classroom": classroom != null
          ? ClassroomDto.fromEntity(classroom!).toMap()
          : null,
    };
  }

  factory LocationDto.fromJson(String source) =>
      LocationDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
