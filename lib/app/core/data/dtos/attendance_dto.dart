import 'dart:convert';

import '../../domain/entities/attendance_entity.dart';
import '../../utils/app_date_utils.dart';
import 'classroom_dto.dart';
import 'virtual_zone_dto.dart';

class AttendanceDto extends AttendanceEntity {
  AttendanceDto({
    required super.id,
    required super.date,
    required super.supportingText,
    required super.startHour,
    required super.endHour,
    required super.duration,
    required super.isAutomatic,
    required super.isHappening,
    required super.virtualZone,
    required super.classroom,
  });

  factory AttendanceDto.fromEntity(AttendanceEntity entity) {
    return AttendanceDto(
      id: entity.id,
      date: entity.date,
      supportingText: entity.supportingText,
      startHour: entity.startHour,
      endHour: entity.endHour,
      duration: entity.duration,
      isAutomatic: entity.isAutomatic,
      isHappening: entity.isHappening,
      virtualZone: entity.virtualZone,
      classroom: entity.classroom,
    );
  }

  factory AttendanceDto.fromMap(Map<String, dynamic> map) {
    return AttendanceDto(
      id: map["id"],
      date: AppDateUtils.storageDateFormat.parse(map["date"]),
      supportingText: map["supportingText"],
      startHour: AppDateUtils.storageDateFormat.parse(map["startHour"]),
      endHour: AppDateUtils.storageDateFormat.parse(map["endHour"]),
      duration: map["duration"],
      isAutomatic: map["isAutomatic"],
      isHappening: map["isHappening"],
      virtualZone: map["virtualZone"],
      classroom: map["classroom"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": AppDateUtils.storageDateFormat.format(date),
      "supportingText": supportingText,
      "startHour": startHour.toString(),
      "endHour": endHour.toString(),
      "duration": duration,
      "isAutomatic": isAutomatic,
      "isHappening": isHappening,
      "virtualZone": VirtualZoneDto.fromEntity(virtualZone).toMap(),
      "classroom": ClassroomDto.fromEntity(classroom).toMap(),
    };
  }

  factory AttendanceDto.fromJson(String json) =>
      AttendanceDto.fromMap(jsonDecode(json));

  String toJson() => jsonEncode(toMap());
}
