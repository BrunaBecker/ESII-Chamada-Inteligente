import '../../enums/status_ping.dart';
import 'attendance_status_entity.dart';
import 'coordinate_entity.dart';

class PingEntity {
  PingEntity({
    required this.id,
    required this.ip,
    required this.date,
    required this.status,
    required this.isContinuous,
    required this.coordinate,
    required this.attendanceStatus,
  });

  int id;
  String ip;
  DateTime date;
  StatusPing status;
  bool isContinuous;
  CoordinateEntity coordinate;
  AttendanceStatusEntity attendanceStatus;
}
