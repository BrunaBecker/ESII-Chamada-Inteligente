import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_routes.dart';
import '../attendance_settings_controller.dart';

class AttendanceStartButton extends StatelessWidget {
  const AttendanceStartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<AttendanceSettingsController>(),
      builder: (controller) {
        return FilledButton(
          onPressed: () async {
            // TODO: start attendance
            await controller.startAttendance();

            Get.snackbar(
              "Chamada",
              "Chamada iniciada com sucesso!",
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(88.0),
            );
            Get.offAllNamed(AppRoutes.home);
          },
          child: const Text("Iniciar"),
        );
      },
    );
  }
}
