import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/spacing.dart';
import 'attendance_settings_controller.dart';
import 'widgets/attendance_creation_panel.dart';

class AttendanceSettingsWidget extends StatelessWidget {
  const AttendanceSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder(
            init: Get.find<AttendanceSettingsController>(),
            builder: (controller) => Obx(
              () => controller.isCreatingAttendance
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Spacing(4.0),
                          Text("Iniciando chamada inteligente"),
                        ],
                      ),
                    )
                  : controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const AttendanceCreationPanel(),
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}
