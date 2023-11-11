import 'dart:convert';

import '../../domain/entities/notification_entity.dart';

class NotificationDto extends NotificationEntity {
  NotificationDto({
    required super.id,
    required super.title,
    required super.supportingText,
    required super.statusNotification,
    required super.isActive,
    required super.isRead,
    required super.person,
  });

  factory NotificationDto.fromEntity(NotificationEntity entity) {
    return NotificationDto(
      id: entity.id,
      title: entity.title,
      supportingText: entity.supportingText,
      statusNotification: entity.statusNotification,
      isActive: entity.isActive,
      isRead: entity.isRead,
      person: entity.person,
    );
  }

  factory NotificationDto.fromMap(Map<String, dynamic> map) {
    return NotificationDto(
      id: map["id"],
      title: map["title"],
      supportingText: map["supportingText"],
      statusNotification: map["statusNotification"],
      isActive: map["isActive"],
      isRead: map["isRead"],
      person: map["person"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "supportingText": supportingText,
      "statusNotification": statusNotification,
      "isActive": isActive,
      "isRead": isRead,
      "person": person,
    };
  }

  factory NotificationDto.fromJson(String source) =>
      NotificationDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
