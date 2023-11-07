import 'dart:ffi';

import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/notification_entity.dart';
import '../../dtos/notification_dto.dart';
import '../base_provider.dart';

class NotificationProvider extends BaseProvider {
  Http http;

  NotificationProvider({required this.http});

  Future<List<NotificationEntity>?> fetchNotificationsByPersonId(
      Long personId) async {
    try {
      final response = await http.get(
        '/notification/$personId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final notifications = response.data
          .map<NotificationDto>(
            (notification) => NotificationDto.fromJson(notification),
          )
          .toList();

      return notifications;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<NotificationEntity?> updateNotification(
      NotificationEntity notificationEntity) async {
    NotificationDto notificationDto =
        NotificationDto.fromEntity(notificationEntity);

    try {
      final response = await http.put(
        '/notification',
        body: notificationDto.toJson(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return NotificationDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<NotificationEntity?> createNotification(
      NotificationEntity notificationEntity) async {
    NotificationDto notificationDto =
        NotificationDto.fromEntity(notificationEntity);

    try {
      final response = await http.post(
        '/notification',
        body: notificationDto.toJson(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return NotificationDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }
}
