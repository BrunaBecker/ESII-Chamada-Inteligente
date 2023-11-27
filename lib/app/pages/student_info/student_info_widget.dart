import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import 'student_info_controller.dart';
import 'widgets/student_info_justification.dart';
import 'widgets/student_info_line.dart';

class StudentInfoWidget extends StatelessWidget {
  const StudentInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetBuilder(
        init: Get.find<StudentInfoController>(),
        builder: (controller) => Obx(
          () => Scaffold(
            appBar: controller.isLoading
                ? null
                : AppBar(
                    backgroundColor: AppColors.surfaceContainer,
                    title: Text(
                      controller.selectedClass.courseName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    centerTitle: true,
                  ),
            body: controller.isLoading
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
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              StudentInfoLine(
                                label: "Presença",
                                value: controller.statistics.presences,
                              ),
                              StudentInfoLine(
                                label: "Faltas",
                                value: controller.statistics.absences,
                              ),
                              StudentInfoLine(
                                label: "Faltas Abonadas",
                                value: controller.statistics.justifications,
                              ),
                              StudentInfoLine(
                                label: "Total de chamadas da disciplina",
                                value: controller.statistics.allAttendances,
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
                            "${controller.statistics.frequency}%",
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
                            itemCount: controller.waivers.length,
                            itemBuilder: (context, index) {
                              final justification = controller.waivers[index];
                              return StudentInfoJustification(
                                justification: justification,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
            bottomNavigationBar: const BottomNavBar(),
          ),
        ),
      ),
    );
  }
}
