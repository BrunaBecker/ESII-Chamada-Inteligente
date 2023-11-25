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
          itemCount: controller.totalStudents + 2,
          itemBuilder: (context, index) {
            if (index >= controller.totalStudents) {
              return const ListTile();
            }

            final student = controller.students[index];
            final status = controller.getStudentStatus(student);

            late final IconData? icon;
            Color? color;
            switch (status?.studentState) {
              case StudentAtAttendanceState.present:
                icon = Icons.check_outlined;
                color = AppColors.green1;
                break;
              case StudentAtAttendanceState.absent:
                icon = Icons.close_outlined;
                color = AppColors.red1;
                break;
              case StudentAtAttendanceState.justified:
                icon = Icons.indeterminate_check_box;
                color = AppColors.green1;
                break;
              default:
                icon = null;
                color = null;
            }
            if (status != null && status.validated == false) {
              color = AppColors.onSurfaceVariant;
            }

            return ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primaryContainer,
                child: Text(
                  student.name.substring(0, 1),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status == null ? "Não respondeu" : "Respondeu",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    student.name,
                  ),
                ],
              ),
              subtitle: status == null
                  ? null
                  : Text(
                      status.validated
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
                  icon,
                  color: color,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () async {
                      await controller.changeStudentPresence(
                        attendanceStatus: status,
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
                    onTap: () async {
                      await controller.changeStudentPresence(
                        attendanceStatus: status,
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
                    onTap: () async {
                      await controller.changeStudentPresence(
                        attendanceStatus: status,
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
