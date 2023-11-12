abstract class RegisterCollegeIdEntity {
  RegisterCollegeIdEntity({
    required this.id,
    required this.identifier,
    required this.dateStarted,
    required this.dateFinished,
    required this.isActive,
  });

  int id;
  String identifier;
  DateTime dateStarted;
  DateTime dateFinished;
  bool isActive;
}
