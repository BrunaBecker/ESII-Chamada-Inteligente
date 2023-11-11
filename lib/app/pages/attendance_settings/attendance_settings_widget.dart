import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/spacing.dart';
import 'attendance_settings_controller.dart';
import 'widgets/attendance_form.dart';
import 'widgets/attendance_settings_title.dart';
import 'widgets/attendance_start_button.dart';
import 'widgets/attendance_use_preset_button.dart';

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
                      : const CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              flexibleSpace: AttendanceSettingsTitle(),
                              toolbarHeight: 135,
                              pinned: true,
                            ),
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: AttendanceUsePresetButton(),
                                        ),
                                        Column(
                                          children: [
                                            AttendanceForm(),
                                            Spacing(4.0),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: AttendanceStartButton(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}
