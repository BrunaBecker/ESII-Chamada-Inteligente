import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/enums/student_at_attendance_state.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import 'attendance_info_controller.dart';
import 'widgets/attendance_filter_options.dart';
import 'widgets/attendance_search_form.dart';

class AttendanceInfoWidget extends StatelessWidget {
  const AttendanceInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetBuilder(
        init: Get.find<AttendanceInfoController>(),
        builder: (controller) => Obx(
          () => controller.isLoading
              ? const CircularProgressIndicator()
              : DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar: controller.isLoading
                        ? null
                        : AppBar(
                            backgroundColor: AppColors.surfaceContainer,
                            title: Text(
                              "Chamada ${controller.selectedAttendance["description"]}",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            centerTitle: true,
                          ),
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 8.0,
                            left: 16.0,
                            right: 16.0,
                            bottom: 16.0,
                          ),
                          child: AttendanceSearchForm(),
                        ),
                        Text(
                          "De ${controller.selectedAttendance["students"].length} alunos, ${controller.totalPresentStudents} estavam presentes",
                          style: const TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const Divider(
                          thickness: 4,
                          color: AppColors.primary,
                        ),
                        const AttendanceFilterOptions(),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.selectedAttendance["students"].length,
                            itemBuilder: (context, index) {
                              final item = controller.selectedAttendance["students"][index];
                              return ListTile(
                                title: Text(item["name"]),
                                subtitle: Text(
                                  item["confirmed"] ? "Resposta validada" : "Valide essa resposta",
                                ),
                                trailing: PopupMenuButton(
                                  icon: Icon(
                                    item["status"] == StudentAtAttendanceState.present
                                        ? Icons.check_outlined
                                        : item["status"] == StudentAtAttendanceState.absent
                                            ? Icons.close_outlined
                                            : Icons.indeterminate_check_box,
                                    color: item["confirmed"]
                                        ? item["status"] == StudentAtAttendanceState.present || item["status"] == StudentAtAttendanceState.justified
                                            ? AppColors.green1
                                            : AppColors.red1
                                        : AppColors.onSurfaceVariant,
                                  ),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      onTap: () {
                                        controller.changeStudentPresence(
                                          student: item,
                                          presence: StudentAtAttendanceState.present,
                                        );
                                      },
                                      child: const ListTile(
                                        leading: Icon(
                                          Icons.check_outlined,
                                          color: AppColors.green1,
                                        ),
                                        title: Text("Presença"),
                                        subtitle: Text("Presença validada"),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        controller.changeStudentPresence(
                                          student: item,
                                          presence: StudentAtAttendanceState.absent,
                                        );
                                      },
                                      child: const ListTile(
                                        leading: Icon(
                                          Icons.close_outlined,
                                          color: AppColors.red1,
                                        ),
                                        title: Text("Falta"),
                                        subtitle: Text("Falta validada"),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        controller.changeStudentPresence(
                                          student: item,
                                          presence: StudentAtAttendanceState.justified,
                                        );
                                      },
                                      child: const ListTile(
                                        leading: Icon(
                                          Icons.indeterminate_check_box,
                                          color: AppColors.green1,
                                        ),
                                        title: Text("Falta abonada"),
                                        subtitle: Text("Falta abonada validada"),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    bottomNavigationBar: const BottomNavBar(),
                  ),
                ),
        ),
      ),
    );
  }
}
