import 'professor_entity.dart';
import 'virtual_zone_entity.dart';

class LocationEntity {
  LocationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isVisible,
    required this.latitude,
    required this.longitude,
    required this.professor,
    required this.virtualZones,
  });

  int id;
  String title;
  String description;
  bool isVisible;
  int latitude;
  int longitude;
  ProfessorEntity professor;
  List<VirtualZoneEntity> virtualZones;
}
