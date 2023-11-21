import 'dart:convert';

import '../../domain/entities/ping_entity.dart';
import '../../enums/status_ping.dart';
import '../../utils/app_date_utils.dart';

class PingDto extends PingEntity {
  PingDto({
    super.id,
    required super.ip,
    required super.date,
    required super.status,
    required super.isContinuous,
    super.coordinateId,
    super.attendanceStatusId,
  });

  factory PingDto.fromEntity(PingEntity entity) {
    return PingDto(
      id: entity.id,
      ip: entity.ip,
      date: entity.date,
      status: entity.status,
      isContinuous: entity.isContinuous,
      coordinateId: entity.coordinateId,
      attendanceStatusId: entity.attendanceStatusId,
    );
  }

  factory PingDto.fromMap(Map<String, dynamic> map) {
    return PingDto(
      id: map["id"],
      ip: map["ip"],
      date: AppDateUtils.storageDateFormat.parse(map["date"]),
      status: StatusPing.fromText(map["status"]),
      isContinuous: map["continuos"],
      coordinateId: map["coordinateId"],
      attendanceStatusId: map["attendanceStatusId"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "ip": ip,
      "date": AppDateUtils.storageDateFormat.format(date),
      "status": status.toText(),
      "continuos": isContinuous,
      "coordinateId": coordinateId,
      "attendanceStatusId": attendanceStatusId,
    };
  }

  factory PingDto.fromJson(String source) =>
      PingDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
