import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../class_info_controller.dart';

class StatsProfessorTab extends StatelessWidget {
  const StatsProfessorTab({super.key});

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
                      const Text(
                        "MÉDIA DE TEMPO DOS ALUNOS PRESENTES EM CADA AULA",
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const Text(
                        "TEMPO (MINUTO) X AULA (DIA)",
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 128.0,
                        ),
                        child: controller.chart.createAttendanceChart(
                          data: controller.allAttendances,
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
