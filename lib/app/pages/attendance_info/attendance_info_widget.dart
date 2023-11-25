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
                              controller.selectedAttendance.supportingText,
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
                          key: const Key('frequency richtext'),
                          "De ${controller.totalStudents} alunos, ${controller.totalPresentStudents} estavam presentes",
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
                            itemCount: controller.totalStudents,
                            itemBuilder: (context, index) {
                              final item = controller.selectedAttendance
                                  .classroom!.students![index];
                              final status = controller.getStudentStatus(
                                item,
                              );

                              if (status == null) {
                                return const SizedBox.shrink();
                              }

                              return ListTile(
                                title: Text(item.name),
                                subtitle: Text(
                                  status.validated
                                      ? "Resposta validada"
                                      : "Valide essa resposta",
                                ),
                                trailing: PopupMenuButton(
                                  icon: Icon(
                                    status.studentState ==
                                            StudentAtAttendanceState.present
                                        ? Icons.check_outlined
                                        : status.studentState ==
                                                StudentAtAttendanceState.absent
                                            ? Icons.close_outlined
                                            : Icons.indeterminate_check_box,
                                    color: status.validated
                                        ? status.studentState ==
                                                    StudentAtAttendanceState
                                                        .present ||
                                                status.studentState ==
                                                    StudentAtAttendanceState
                                                        .justified
                                            ? AppColors.green1
                                            : AppColors.red1
                                        : AppColors.onSurfaceVariant,
                                  ),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      onTap: () {
                                        controller.changeStudentPresence(
                                          attendanceStatus: status,
                                          presence:
                                              StudentAtAttendanceState.present,
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
                                          attendanceStatus: status,
                                          presence:
                                              StudentAtAttendanceState.absent,
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
                                          attendanceStatus: status,
                                          presence: StudentAtAttendanceState
                                              .justified,
                                        );
                                      },
                                      child: const ListTile(
                                        leading: Icon(
                                          Icons.indeterminate_check_box,
                                          color: AppColors.green1,
                                        ),
                                        title: Text("Falta abonada"),
                                        subtitle:
                                            Text("Falta abonada validada"),
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
