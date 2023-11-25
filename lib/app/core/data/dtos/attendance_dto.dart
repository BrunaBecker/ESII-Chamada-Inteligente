import 'dart:convert';

import '../../domain/entities/attendance_entity.dart';
import '../../utils/app_date_utils.dart';
import 'classroom_dto.dart';
import 'virtual_zone_dto.dart';

class AttendanceDto extends AttendanceEntity {
  AttendanceDto({
    super.id,
    required super.date,
    required super.supportingText,
    required super.startHour,
    required super.endHour,
    required super.isAutomatic,
    required super.isHappening,
    super.virtualZone,
    super.classroom,
  });

  factory AttendanceDto.fromEntity(AttendanceEntity entity) {
    return AttendanceDto(
      id: entity.id,
      date: entity.date,
      supportingText: entity.supportingText,
      startHour: entity.startHour,
      endHour: entity.endHour,
      isAutomatic: entity.isAutomatic,
      isHappening: entity.isHappening,
      virtualZone: entity.virtualZone,
      classroom: entity.classroom,
    );
  }

  factory AttendanceDto.fromMap(Map<String, dynamic> map) {
    // Mapping Virtual Zone
    VirtualZoneDto? virtualZone;
    if (map["virtualZone"] != null) {
      virtualZone = VirtualZoneDto.fromMap(map["virtualZone"]);
    }

    // Mapping Classroom
    ClassroomDto? classroom;
    if (map["classroom"] != null) {
      classroom = ClassroomDto.fromMap(map["classroom"]);
    }

    return AttendanceDto(
      id: map["id"],
      date: AppDateUtils.storageDateFormat.parse(map["date"]),
      supportingText: map["supportingText"],
      startHour: map["startHour"],
      endHour: map["endHour"],
      isAutomatic: map["automatic"],
      isHappening: map["happening"],
      virtualZone: virtualZone,
      classroom: classroom,
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping Virtual Zone
    Map<String, dynamic>? virtualZoneAsMap;
    if (virtualZone != null) {
      virtualZoneAsMap = VirtualZoneDto.fromEntity(virtualZone!).toMap();
    }

    // Mapping Classroom
    Map<String, dynamic>? classroomAsMap;
    if (classroom != null) {
      classroomAsMap = ClassroomDto.fromEntity(classroom!).toMap();
    }

    return {
      "id": id,
      "date": AppDateUtils.storageDateFormat.format(date),
      "supportingText": supportingText,
      "startHour": startHour,
      "endHour": endHour,
      "automatic": isAutomatic,
      "happening": isHappening,
      "virtualZone": virtualZoneAsMap,
      "classroom": classroomAsMap,
    };
  }

  factory AttendanceDto.fromJson(String json) =>
      AttendanceDto.fromMap(jsonDecode(json));

  String toJson() => jsonEncode(toMap());
}
