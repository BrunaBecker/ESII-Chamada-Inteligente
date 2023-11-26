import '../../enums/status_ping.dart';
import 'attendance_status_entity.dart';
import 'coordinate_entity.dart';

class PingEntity {
  PingEntity({
    this.id,
    this.ip,
    required this.date,
    this.status,
    required this.isContinuous,
    this.coordinate,
    required this.attendanceStatus,
  });

  int? id;
  String? ip;
  DateTime date;
  StatusPing? status;
  bool isContinuous;
  CoordinateEntity? coordinate;
  AttendanceStatusEntity attendanceStatus;
}
