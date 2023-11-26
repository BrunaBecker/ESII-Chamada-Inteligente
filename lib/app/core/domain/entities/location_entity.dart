import 'classroom_entity.dart';
import 'coordinate_entity.dart';
import 'professor_entity.dart';

class LocationEntity {
  LocationEntity({
    this.id,
    required this.title,
    required this.description,
    this.isActive = true,
    this.coordinate,
    this.professor,
    this.classroom,
  });

  int? id;
  String title;
  String description;
  bool isActive;
  CoordinateEntity? coordinate;
  ProfessorEntity? professor;
  ClassroomEntity? classroom;
}
