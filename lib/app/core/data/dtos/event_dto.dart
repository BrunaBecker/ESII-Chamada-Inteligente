import 'dart:convert';

import '../../domain/entities/event_entity.dart';
import '../../enums/event_status.dart';
import '../../utils/app_date_utils.dart';
import 'calendar_dto.dart';
import 'classroom_dto.dart';

class EventDto extends EventEntity {
  EventDto({
    required super.id,
    required super.name,
    required super.date,
    required super.description,
    required super.classroom,
    required super.status,
  });

  factory EventDto.fromEntity(EventEntity entity) {
    return EventDto(
      id: entity.id,
      name: entity.name,
      date: entity.date,
      description: entity.description,
      classroom: entity.classroom,
      status: entity.status,
    );
  }

  factory EventDto.fromMap(Map<String, dynamic> map) {
    // Mapping Calendars
    List<CalendarDto> calendars = [];
    for (var calendarMap in map["calendars"]) {
      calendars.add(CalendarDto.fromMap(calendarMap));
    }

    return EventDto(
      id: map["id"],
      name: map["name"],
      date: AppDateUtils.storageDateFormat.parse(map["date"]),
      description: map["description"],
      classroom: ClassroomDto.fromMap(map["classroom"]),
      status: EventStatus.values[map["status"]],
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping Calendars

    return {
      "id": id,
      "name": name,
      "date": AppDateUtils.storageDateFormat.format(date),
      "description": description,
      "classroom": ClassroomDto.fromEntity(classroom).toMap(),
      "status": status.index,
    };
  }

  factory EventDto.fromJson(String source) =>
      EventDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
