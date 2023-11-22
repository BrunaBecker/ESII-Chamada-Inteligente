import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enums/student_at_attendance_state.dart';
import '../../../core/theme/app_colors.dart';
import '../current_attendance_controller.dart';

class CurrentAttendanceStudentList extends StatelessWidget {
  const CurrentAttendanceStudentList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CurrentAttendanceController>(),
      builder: (controller) => SliverToBoxAdapter(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.currentAttendance["students"].length + 2,
          itemBuilder: (context, index) {
            if (index >= controller.currentAttendance["students"].length) {
              return const ListTile();
            }

            final student = controller.currentAttendance["students"][index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primaryContainer,
                child: Text(
                  student["name"]?[0] ?? "",
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student["answered"] ? "Respondeu" : "Não respondeu",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    student["name"],
                  ),
                ],
              ),
              subtitle: Text(
                student["confirmed"]
                    ? "Resposta validada"
                    : "Valide essa resposta",
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              trailing: PopupMenuButton(
                key: const Key('student status popup menu button'),
                icon: Icon(
                  key: const Key('student status icon'),
                  student["status"] == StudentAtAttendanceState.present
                      ? Icons.check_outlined
                      : student["status"] == StudentAtAttendanceState.absent
                          ? Icons.close_outlined
                          : Icons.indeterminate_check_box,
                  color: student["confirmed"]
                      ? student["status"] == StudentAtAttendanceState.present ||
                              student["status"] ==
                                  StudentAtAttendanceState.justified
                          ? AppColors.green1
                          : AppColors.red1
                      : AppColors.onSurfaceVariant,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () {
                      controller.changeStudentPresence(
                        student: student,
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
                        student: student,
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
                        student: student,
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
      ),
    );
  }
}
