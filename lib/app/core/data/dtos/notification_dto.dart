import 'dart:convert';

import '../../domain/entities/notification_entity.dart';
import '../../enums/status_notification.dart';

class NotificationDto extends NotificationEntity {
  NotificationDto({
    super.id,
    required super.title,
    required super.supportingText,
    required super.statusNotification,
    super.isActive = true,
    super.isRead = false,
    required super.personId,
  });

  factory NotificationDto.fromEntity(NotificationEntity entity) {
    return NotificationDto(
      id: entity.id,
      title: entity.title,
      supportingText: entity.supportingText,
      statusNotification: entity.statusNotification,
      isActive: entity.isActive,
      isRead: entity.isRead,
      personId: entity.personId,
    );
  }

  factory NotificationDto.fromMap(Map<String, dynamic> map) {
    return NotificationDto(
      id: map["id"],
      title: map["title"],
      supportingText: map["supportingText"],
      statusNotification:
          StatusNotification.fromText(map["statusNotification"]),
      isActive: map["active"],
      isRead: map["read"],
      personId: map["personId"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "supportingText": supportingText,
      "statusNotification": statusNotification.toText(),
      "active": isActive,
      "read": isRead,
      "personId": personId,
    };
  }

  factory NotificationDto.fromJson(String source) =>
      NotificationDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
