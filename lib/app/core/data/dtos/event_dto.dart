import 'dart:convert';

import '../../domain/entities/event_entity.dart';
import '../../enums/event_status.dart';
import '../../utils/app_date_utils.dart';
import 'classroom_dto.dart';

class EventDto extends EventEntity {
  EventDto({
    super.id,
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
    return EventDto(
      id: map["id"],
      name: map["name"],
      date: AppDateUtils.storageDateFormat.parse(map["date"]),
      description: map["description"],
      classroom: ClassroomDto.fromMap(map["classroom"]),
      status: EventStatus.fromText(map["status"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "date": AppDateUtils.storageDateFormat.format(date),
      "description": description,
      "classroom": ClassroomDto.fromEntity(classroom).toMap(),
      "status": status.toText(),
    };
  }

  factory EventDto.fromJson(String source) =>
      EventDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
