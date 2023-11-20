import '../../enums/status_notification.dart';

class NotificationEntity {
  NotificationEntity({
    this.id,
    required this.title,
    required this.supportingText,
    required this.statusNotification,
    this.isActive = true,
    this.isRead = false,
    required this.personId,
  });

  int? id;
  String title;
  String supportingText;
  StatusNotification statusNotification;
  bool isActive;
  bool isRead;
  int personId;
}
