abstract class RegisterCollegeIdEntity {
  RegisterCollegeIdEntity({
    required this.identifier,
    required this.dateStarted,
    required this.dateFinished,
    required this.isActive,
  });

  String identifier;
  DateTime dateStarted;
  DateTime dateFinished;
  bool isActive;
}
