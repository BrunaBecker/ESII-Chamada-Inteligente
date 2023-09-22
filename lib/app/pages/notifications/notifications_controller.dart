import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final _isLoading = true.obs;
  final _notifications = <Map<String, dynamic>>[].obs;

  bool get isLoading => _isLoading.value;
  List get notifications => _notifications.toList();
  List get unreadNotifications => _notifications.where((element) => !element["isRead"]).toList();
  List get readNotifications => _notifications.where((element) => element["isRead"]).toList();
  int get totalUnreadNotifications => unreadNotifications.length;

  @override
  void onReady() {
    _isLoading.value = true;
    // TODO: get notifications
    for (var i = 1; i <= 10; i++) {
      _notifications.add({
        "id": i,
        "title": "Engenharia de Software $i - A1",
        "description": "A chamada da turma Engenharia de Software $i - A1 foi iniciada!",
        "isRead": false,
      });
    }

    _isLoading.value = false;
    super.onReady();
  }

  void toggleReadNotification(int id) {
    final index = _notifications.indexWhere((element) => element["id"] == id);
    if (index != -1) {
      _notifications[index]["isRead"] = !_notifications[index]["isRead"];
    }
    update();
  }

  void removeNotification(int id) {
    final index = _notifications.indexWhere((element) => element["id"] == id);
    if (index != -1) {
      _notifications.removeAt(index);
    }
  }
}
