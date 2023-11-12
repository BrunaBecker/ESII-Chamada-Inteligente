import 'dart:convert';

import '../../domain/entities/setting_entity.dart';

class SettingDto extends SettingEntity {
  SettingDto({
    required super.id,
    required super.automaticSaveLocalization,
    required super.usePredefinedCalendarForAttendance,
    required super.silentMode,
  });

  factory SettingDto.fromEntity(SettingEntity entity) {
    return SettingDto(
      id: entity.id,
      automaticSaveLocalization: entity.automaticSaveLocalization,
      usePredefinedCalendarForAttendance:
          entity.usePredefinedCalendarForAttendance,
      silentMode: entity.silentMode,
    );
  }

  factory SettingDto.fromMap(Map<String, dynamic> map) {
    return SettingDto(
      id: map["id"],
      automaticSaveLocalization: map["automaticSaveLocalization"],
      usePredefinedCalendarForAttendance:
          map["usePredefinedCalendarForAttendance"],
      silentMode: map["silentMode"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "automaticSaveLocalization": automaticSaveLocalization,
      "usePredefinedCalendarForAttendance": usePredefinedCalendarForAttendance,
      "silentMode": silentMode,
    };
  }

  factory SettingDto.fromJson(String source) =>
      SettingDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
