import '../../enums/status_notification.dart';

class NotificationEntity {
  NotificationEntity({
    required this.id,
    required this.title,
    required this.supportingText,
    required this.statusNotification,
    required this.isActive,
    required this.isRead,
    required this.person,
  });

  int id;
  String title;
  String supportingText;
  StatusNotification statusNotification;
  bool isActive;
  bool isRead;
  int person;
}
