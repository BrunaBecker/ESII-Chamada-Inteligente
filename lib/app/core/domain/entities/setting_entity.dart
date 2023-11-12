class SettingEntity {
  SettingEntity({
    required this.id,
    required this.automaticSaveLocalization,
    required this.usePredefinedCalendarForAttendance,
    required this.silentMode,
  });

  int id;
  bool automaticSaveLocalization;
  bool usePredefinedCalendarForAttendance;
  bool silentMode;
}
