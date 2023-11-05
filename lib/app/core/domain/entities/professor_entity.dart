import 'classroom_entity.dart';
import 'location_entity.dart';
import 'person_entity.dart';

class ProfessorEntity extends PersonEntity {
  ProfessorEntity({
    required super.id,
    required super.name,
    required super.socialName,
    required super.birthDate,
    required super.isActive,
    required super.cpf,
    required super.email,
    required super.password,
    required super.register,
    required super.setting,
    required super.profileImage,
    required super.comments,
    required super.notifications,
    required this.locations,
    required this.classrooms,
  });

  List<LocationEntity> locations;
  List<ClassroomEntity> classrooms;
}
