import 'person_entity.dart';

class SettingEntity {
  SettingEntity({
    required this.id,
    required this.automaticSaveLocalization,
    required this.usePredefinedCalendarForAttendance,
    required this.silentMode,
    required this.person,
  });

  int id;
  bool automaticSaveLocalization;
  bool usePredefinedCalendarForAttendance;
  bool silentMode;
  PersonEntity person;
}
