import 'person_entity.dart';

abstract class RegisterCollegeIdEntity {
  RegisterCollegeIdEntity({
    required this.id,
    required this.identifier,
    required this.dateStarted,
    required this.dateFinished,
    required this.isActive,
    required this.person,
  });

  int id;
  String identifier;
  DateTime dateStarted;
  DateTime dateFinished;
  bool isActive;
  PersonEntity person;
}
