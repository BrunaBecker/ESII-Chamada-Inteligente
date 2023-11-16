import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/spacing.dart';
import '../class_info_controller.dart';
import 'student_attendance_trailing.dart';

class AttendancesStudentTab extends StatelessWidget {
  const AttendancesStudentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<ClassInfoController>(),
      builder: (controller) => Obx(
        () => controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: FilledButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.date_range_outlined),
                          label: const Text("Filtrar por data"),
                        ),
                      ),
                      const Spacing(8.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Total de chamadas: ${controller.selectedClass["attendances"].length}",
                          style: const TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount:
                              controller.selectedClass["attendances"].length,
                          itemBuilder: (context, index) {
                            final item =
                                controller.selectedClass["attendances"][index];
                            return ListTile(
                              title: Text(item["date"]),
                              subtitle: Text(item["description"]),
                              trailing: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: StudentAttendanceTrailing(
                                  status: item["attendanceStatus"],
                                  isVerified: item["statusVerified"],
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 16.0,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 1,
                            child: Divider(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
