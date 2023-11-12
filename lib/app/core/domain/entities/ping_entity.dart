import '../../enums/status_ping.dart';

class PingEntity {
  PingEntity({
    required this.id,
    required this.ip,
    required this.date,
    required this.status,
    required this.isContinuous,
    required this.coordinateId,
    required this.attendanceStatusId,
  });

  int id;
  String ip;
  DateTime date;
  StatusPing status;
  bool isContinuous;
  int coordinateId;
  int attendanceStatusId;
}
