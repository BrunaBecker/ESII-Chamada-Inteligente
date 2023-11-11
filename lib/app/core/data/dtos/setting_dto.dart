import 'dart:convert';

import '../../domain/entities/professor_entity.dart';
import '../../domain/entities/setting_entity.dart';
import '../../domain/entities/student_entity.dart';
import 'professor_dto.dart';
import 'student_dto.dart';

class SettingDto extends SettingEntity {
  SettingDto({
    required super.id,
    required super.automaticSaveLocalization,
    required super.usePredefinedCalendarForAttendance,
    required super.silentMode,
    required super.person,
  });

  factory SettingDto.fromEntity(SettingEntity entity) {
    return SettingDto(
      id: entity.id,
      automaticSaveLocalization: entity.automaticSaveLocalization,
      usePredefinedCalendarForAttendance:
          entity.usePredefinedCalendarForAttendance,
      silentMode: entity.silentMode,
      person: entity.person,
    );
  }

  factory SettingDto.fromMap(Map<String, dynamic> map) {
    final dynamic person;
    // Checking person type
    if ((map["person"] as Map).containsKey("siape")) {
      person = ProfessorDto.fromMap(map["person"]);
    } else {
      person = StudentDto.fromMap(map["person"]);
    }

    return SettingDto(
      id: map["id"],
      automaticSaveLocalization: map["automaticSaveLocalization"],
      usePredefinedCalendarForAttendance:
          map["usePredefinedCalendarForAttendance"],
      silentMode: map["silentMode"],
      person: person,
    );
  }

  Map<String, dynamic> toMap() {
    final dynamic personAsMap;
    // Checking person type
    if (person is ProfessorDto) {
      personAsMap = ProfessorDto.fromEntity(person as ProfessorEntity);
    } else {
      personAsMap = StudentDto.fromEntity(person as StudentEntity);
    }

    return {
      "id": id,
      "automaticSaveLocalization": automaticSaveLocalization,
      "usePredefinedCalendarForAttendance": usePredefinedCalendarForAttendance,
      "silentMode": silentMode,
      "person": personAsMap,
    };
  }

  factory SettingDto.fromJson(String source) =>
      SettingDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
