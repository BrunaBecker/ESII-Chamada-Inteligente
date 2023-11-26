import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enums/student_at_attendance_state.dart';
import '../../../core/theme/app_colors.dart';
import '../class_info_controller.dart';
import '../../../core/widgets/waiver_creation_dialog.dart';

class StudentAttendanceTrailing extends StatelessWidget {
  const StudentAttendanceTrailing({
    super.key,
    required this.status,
    required this.isVerified,
  });

  final StudentAtAttendanceState status;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassInfoController>(
      init: Get.find<ClassInfoController>(),
      builder: (controller) {
        final color = isVerified ? null : AppColors.onSurfaceVariant;

        if (status == StudentAtAttendanceState.absent) {
          return PopupMenuButton(
            child: Icon(
              Icons.close_outlined,
              color: color ?? AppColors.red1,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => Obx(
                      () => controller.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : WaiverCreationDialog(
                              formKey: controller.formKey,
                              waiverNameValidator:
                                  controller.validator.validateNotNullInput,
                              waiverFileNameController:
                                  controller.waiverFileNameController,
                              waiverTitleValidator:
                                  controller.validator.validateNotNullInput,
                              waiverTitleController:
                                  controller.waiverTitleController,
                              waiverDescriptionValidator:
                                  controller.validator.validateNotNullInput,
                              waiverDescriptionController:
                                  controller.waiverDescriptionController,
                              onFileSelection: () {},
                              onWaiverCreation: () {},
                            ),
                    ),
                  );
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.indeterminate_check_box,
                    color: AppColors.yellow,
                  ),
                  title: Text("Falta abonada"),
                  subtitle: Text(
                    "Enviar justificativa",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        return status == StudentAtAttendanceState.present
            ? Icon(
                Icons.check_outlined,
                color: color ?? AppColors.green1,
              )
            : status == StudentAtAttendanceState.absent
                ? Icon(
                    Icons.close_outlined,
                    color: color ?? AppColors.red1,
                  )
                : Icon(
                    Icons.indeterminate_check_box,
                    color: color ?? AppColors.green1,
                  );
      },
    );
  }
}
