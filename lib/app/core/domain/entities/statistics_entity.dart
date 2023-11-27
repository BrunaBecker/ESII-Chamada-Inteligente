class StatisticsEntity {
  StatisticsEntity({
    this.id,
    required this.presences,
    required this.justifications,
    required this.allAttendances,
    required this.frequency,
  });

  int? id;
  String presences;
  String justifications;
  String allAttendances;
  String frequency;
}
