import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../student_info/widgets/student_info_justification.dart';
import '../../student_info/widgets/student_info_line.dart';
import '../class_info_controller.dart';

class StudentInfoTab extends StatelessWidget {
  const StudentInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<ClassInfoController>(),
      builder: (controller) => Obx(
        () => controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.selectedStudent.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.green1,
                            ),
                          ),
                          Text(
                            controller.selectedStudent.register.identifier,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 4,
                      color: AppColors.primary,
                    ),
                    // TODO: add real presence values
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          StudentInfoLine(
                            label: "Presença",
                            value: controller.studentStatistics.presences,
                          ),
                          StudentInfoLine(
                            label: "Faltas",
                            value: controller.studentStatistics.absences,
                          ),
                          StudentInfoLine(
                            label: "Faltas Abonadas",
                            value: controller.studentStatistics.justifications,
                          ),
                          StudentInfoLine(
                            label: "Total de chamadas da disciplina",
                            value: controller.studentStatistics.allAttendances,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        right: 16.0,
                        bottom: 8.0,
                      ),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${controller.studentStatistics.frequency}%",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.green1,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 4,
                      color: AppColors.primary,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Atestados enviados",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 4,
                      color: AppColors.primary,
                    ),
                    Expanded(
                      child: ListView.builder(
                        // itemCount: controller.selectedStudent!["justifications"].length,
                        itemCount: 0,
                        itemBuilder: (context, index) {
                          // final justification = controller.selectedStudent!["justifications"][index];
                          const justification = {"": ""};
                          return const StudentInfoJustification(
                            justification: justification,
                            showActions: false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
