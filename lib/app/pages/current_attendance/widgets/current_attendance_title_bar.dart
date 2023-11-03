import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/spacing.dart';
import '../current_attendance_controller.dart';

class CurrentAttendanceTitleBar extends StatelessWidget {
  const CurrentAttendanceTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CurrentAttendanceController>(),
      builder: (controller) => SliverAppBar(
        flexibleSpace: Column(
          children: [
            Text(
              controller.currentAttendance["name"],
              style: const TextStyle(
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacing(8.0),
            const LinearProgressIndicator(
              value: 0.75,
            ),
          ],
        ),
        pinned: true,
      ),
    );
  }
}