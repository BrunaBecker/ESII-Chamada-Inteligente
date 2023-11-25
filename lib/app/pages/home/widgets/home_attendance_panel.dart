import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enums/student_at_attendance_state.dart';
import '../../../core/theme/app_colors.dart';
import '../home_controller.dart';
import 'justificate_button.dart';
import 'location_text.dart';

class HomeAttendancePanel extends StatelessWidget {
  const HomeAttendancePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: Get.find<HomeController>(),
      builder: (controller) => Obx(
        () => controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.attendance == null
                ? const Center(
                    child: Text("Você não possui uma chamada em andamento."),
                  )
                : Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          const Text("Registre sua presença!"),
                          SizedBox(
                            child: AlertDialog(
                              insetPadding: const EdgeInsets.all(16.0),
                              contentPadding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                side: const BorderSide(
                                  width: 1,
                                  color: AppColors.outlineVariant,
                                ),
                              ),
                              content: Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: AppColors.primary,
                                      child: Text(
                                        controller.classroom?.className ?? "",
                                        style: const TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      controller.classroom?.courseName ?? "",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: Text(
                                      controller.classroom?.code ?? "",
                                    ),
                                    trailing: Icon(
                                      Icons.online_prediction_outlined,
                                      color: controller.virtualZone == null
                                          ? AppColors.red1
                                          : AppColors.green1,
                                    ),
                                  ),
                                  const LocationText(),
                                ],
                              ),
                              actions: buildActions(controller),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  List<Widget>? buildActions(HomeController controller) {
    final status = controller.attendanceStatus;
    IconData answerIcon = Icons.check_outlined;
    String answerText = "";

    if (status != null) {
      switch (status.studentState) {
        case StudentAtAttendanceState.present:
          answerIcon = Icons.check_outlined;
          answerText = "Presença marcada";
          break;
        case StudentAtAttendanceState.absent:
          answerIcon = Icons.close_outlined;
          answerText = "Ausência marcada";
          break;
        case StudentAtAttendanceState.justified:
          answerIcon = Icons.indeterminate_check_box;
          answerText = "Ausência justificada";
          break;
      }
    }

    return status?.studentHasResponded ?? false
        ? [
            FilledButton(
              onPressed: null,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              child: IntrinsicWidth(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        answerIcon,
                        size: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        answerText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
        : [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.outlineVariant,
                  width: 1,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: const JustificateButton(),
            ),
            FilledButton(
              onPressed: () async {
                await controller.createAttendanceStatus(
                  StudentAtAttendanceState.present,
                );
                Get.back();
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              child: const IntrinsicWidth(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.check_outlined,
                        size: 18,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text("Presente"),
                    ),
                  ],
                ),
              ),
            ),
          ];
  }
}
