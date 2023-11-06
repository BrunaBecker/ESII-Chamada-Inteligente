import 'coordinate_entity.dart';
import 'professor_entity.dart';
import 'virtual_zone_entity.dart';

class LocationEntity {
  LocationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isActive,
    required this.coordinate,
    required this.professor,
    required this.virtualZones,
  });

  int id;
  String title;
  String description;
  bool isActive;
  CoordinateEntity coordinate;
  ProfessorEntity professor;
  List<VirtualZoneEntity> virtualZones;
}
