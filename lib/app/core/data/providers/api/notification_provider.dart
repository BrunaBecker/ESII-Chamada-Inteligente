import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/notification_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../dtos/notification_dto.dart';
import '../base_provider.dart';

class NotificationProvider extends BaseProvider {
  Http http;

  NotificationProvider({required this.http});

  Future<List<NotificationEntity>?> fetchActivesByPersonId(int personId) async {
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
            (notification) => NotificationDto.fromMap(notification),
          )
          .toList();

      return notifications;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<NotificationEntity?> create(
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

      return NotificationDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<bool> delete(NotificationEntity notification) async {
    try {
      final response = await http.delete(
        '/notification/${notification.id}',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return response.data;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return false;
    }
  }

  Future<bool> deleteById(int notificationId) async {
    try {
      final response = await http.delete(
        '/notification/$notificationId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return response.data;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return false;
    }
  }

  Future<NotificationEntity?> update(
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

      return NotificationDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }
}
