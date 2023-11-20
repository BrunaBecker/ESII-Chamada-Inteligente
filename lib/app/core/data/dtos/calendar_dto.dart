import 'dart:convert';

import '../../domain/entities/calendar_entity.dart';
import 'event_dto.dart';

class CalendarDto extends CalendarEntity {
  CalendarDto({
    super.id,
    required super.events,
  });

  factory CalendarDto.fromEntity(CalendarEntity entity) {
    return CalendarDto(
      id: entity.id,
      events: entity.events,
    );
  }

  factory CalendarDto.fromMap(Map<String, dynamic> map) {
    // Mapping Events
    List<EventDto> events = [];
    for (var eventMap in map["events"]) {
      events.add(EventDto.fromMap(eventMap));
    }

    return CalendarDto(
      id: map["id"],
      events: events,
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping Events
    List<Map<String, dynamic>> events = [];
    for (var event in this.events) {
      events.add(EventDto.fromEntity(event).toMap());
    }

    return {
      "id": id,
      "events": events,
    };
  }

  String toJson() => json.encode(toMap());

  factory CalendarDto.fromJson(String source) =>
      CalendarDto.fromMap(json.decode(source));
}
