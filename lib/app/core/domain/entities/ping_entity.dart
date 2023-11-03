import 'attendance_status_entity.dart';

class PingEntity {
  PingEntity({
    required this.ip,
    required this.id,
    required this.date,
    required this.status,
    required this.attendanceStatus,
  });

  String ip;
  int id;
  DateTime date;
  bool status;
  AttendanceStatusEntity attendanceStatus;
}
