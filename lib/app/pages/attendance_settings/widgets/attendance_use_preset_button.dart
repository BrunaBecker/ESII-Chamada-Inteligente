import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/spacing.dart';
import '../attendance_settings_controller.dart';

class AttendanceUsePresetButton extends StatelessWidget {
  const AttendanceUsePresetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceSettingsController>(
      init: Get.find<AttendanceSettingsController>(),
      builder: (controller) => Obx(
        () => Row(
          children: [
            Switch(
              value: controller.usePreset,
              onChanged: (_) => controller.toggleUsePreset(),
            ),
            const Spacing(8.0),
            const Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  "Usar as predefinições de chamada",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
