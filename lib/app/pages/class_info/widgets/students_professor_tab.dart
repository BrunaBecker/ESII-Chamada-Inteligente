import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../class_info_controller.dart';

class StudentsProfessorTab extends StatelessWidget {
  const StudentsProfessorTab({super.key});

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.ios_share_outlined,
                              size: 18,
                            ),
                            label: const Text(
                              "Lista de Reprovados",
                              style: TextStyle(
                                color: AppColors.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            style: ButtonStyle(
                              iconColor: MaterialStateProperty.all(
                                  AppColors.onSurface),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.all(8.0),
                              ),
                            ),
                          ),
                          Text(
                            "${controller.selectedClassroom.students?.length ?? 0} ${controller.selectedClassroom.students?.length == 1 ? "Aluno" : "Alunos"}",
                            style: const TextStyle(
                              color: AppColors.onSecondaryFixedVariant,
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 5,
                        margin: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount:
                              controller.selectedClassroom.students?.length ??
                                  0,
                          itemBuilder: (context, index) {
                            final item =
                                controller.selectedClassroom.students![index];
                            return ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                margin: const EdgeInsets.only(left: 16.0),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryContainer,
                                ),
                                child: Center(
                                  child: Text(
                                    item.name.substring(0, 1),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.onPrimaryContainer,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(item.name),
                              trailing: IconButton(
                                key: const Key(
                                    'go to student information button'),
                                icon: const Icon(Icons.arrow_right_outlined),
                                onPressed: () async {
                                  await controller.fetchStatistics(
                                    student: item,
                                  );
                                  Get.toNamed(
                                    "/student-info",
                                    arguments: {
                                      "studentInfo": item,
                                      "classInfo": controller.selectedClassroom,
                                      "statistics":
                                          controller.studentStatistics,
                                    },
                                  );
                                },
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 0.0,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
