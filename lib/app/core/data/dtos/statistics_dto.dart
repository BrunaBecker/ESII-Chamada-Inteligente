import 'dart:convert';

import '../../domain/entities/statistics_entity.dart';

class StatisticsDto extends StatisticsEntity {
  StatisticsDto({
    required super.presences,
    required super.absences,
    required super.justifications,
    required super.allAttendances,
    required super.frequency,
  });

  factory StatisticsDto.fromEntity(StatisticsEntity entity) {
    return StatisticsDto(
      presences: entity.presences,
      absences: entity.absences,
      justifications: entity.justifications,
      allAttendances: entity.allAttendances,
      frequency: entity.frequency,
    );
  }

  factory StatisticsDto.fromMap(Map<String, dynamic> map) {
    return StatisticsDto(
      presences: map["presences"],
      absences: map["absences"],
      justifications: map["justifications"],
      allAttendances: map["allAttendances"],
      frequency: map["frequency"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "presences": presences,
      "justifications": justifications,
      "allAttendances": allAttendances,
      "frequency": frequency,
    };
  }

  factory StatisticsDto.fromJson(String json) =>
      StatisticsDto.fromMap(jsonDecode(json));

  String toJson() => jsonEncode(toMap());
}
