import 'classroom_entity.dart';
import 'coordinate_entity.dart';
import 'professor_entity.dart';
import 'virtual_zone_entity.dart';

class LocationEntity {
  LocationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isActive,
    this.coordinate,
    this.professor,
    this.virtualZones,
    this.classroom,
  });

  int id;
  String title;
  String description;
  bool isActive;

  CoordinateEntity? coordinate;
  ProfessorEntity? professor;
  List<VirtualZoneEntity>? virtualZones;
  ClassroomEntity? classroom;
}
