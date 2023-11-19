import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/domain/entities/person_entity.dart';
import '../../core/enums/student_at_attendance_state.dart';
import '../notifications/notifications_controller.dart';

class HomeController extends GetxController {
  HomeController({
    required appController,
  }) : _appController = appController;

  final AppController _appController;

  final _isLoading = true.obs;
  final _attendance = Rx<Map<String, dynamic>?>(null);

  bool get isLoading => _isLoading.value;
  UserType? get userType => _appController.userType;
  PersonEntity get user => _appController.user!;
  Map<String, dynamic>? get attendance => _attendance.value;
  bool get hasAttendance => _attendance.value?["address"] != null;

  @override
  void onReady() {
    super.onReady();

    final notificationsController = Get.find<NotificationsController>();
    notificationsController.fetch();
    fetchAttendance();

    _isLoading.value = false;
  }

  void fetchAttendance() {
    _attendance.value = {
      "class": "Engenharia de Software II",
      "code": "TCC00001",
      "name": "A1",
      "status": StudentAtAttendanceState.present,
      "answered": false,
      "justifications": [],
      "address":
          "Av. Gal. Milton Tavares de Souza, s/n - São Domingos, Niterói - RJ, 24210-310",
      "latitude": -22.90627,
      "longitude": -43.13323,
    };
  }
}
