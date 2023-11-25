import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enums/student_at_attendance_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/waiver_creation_dialog.dart';
import '../home_controller.dart';

class JustificateButton extends StatelessWidget {
  const JustificateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: Get.find<HomeController>(),
      builder: (controller) => InkWell(
        onTapDown: (details) {
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
              details.globalPosition.dx,
              details.globalPosition.dy,
              details.globalPosition.dx,
              details.globalPosition.dy,
            ),
            items: [
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
                  ),
                  title: Text("Falta Abonável"),
                ),
              ),
              PopupMenuItem(
                onTap: () async {
                  await controller.createAttendanceStatus(
                    StudentAtAttendanceState.absent,
                  );
                  Get.back();
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.close_outlined,
                  ),
                  title: Text("Falta"),
                ),
              ),
            ],
          );
        },
        child: const IntrinsicWidth(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.arrow_drop_down_outlined,
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text(
                  "Falta",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
