import '../../enums/status_ping.dart';

class PingEntity {
  PingEntity({
    this.id,
    required this.ip,
    required this.date,
    required this.status,
    required this.isContinuous,
    this.coordinateId,
    this.attendanceStatusId,
  });

  int? id;
  String ip;
  DateTime date;
  StatusPing status;
  bool isContinuous;
  int? coordinateId;
  int? attendanceStatusId;
}
