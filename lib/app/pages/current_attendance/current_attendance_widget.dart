import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/spacing.dart';
import 'current_attendance_controller.dart';
import 'widgets/current_attendance_local_sheet.dart';
import 'widgets/current_attendance_search_bar.dart';
import 'widgets/current_attendance_student_list.dart';
import 'widgets/current_attendance_title_bar.dart';
import 'widgets/current_attendance_virtual_zone_sheet.dart';

class CurrentAttendanceWidget extends StatelessWidget {
  const CurrentAttendanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder(
            init: Get.find<CurrentAttendanceController>(),
            builder: (controller) => Obx(
              () => Scaffold(
                appBar: controller.isLoading
                    ? null
                    : AppBar(
                        leading: Icon(
                          key: const Key('live icon'),
                          Icons.online_prediction_outlined,
                          color: controller.virtualZone == null
                              ? AppColors.red1
                              : AppColors.green1,
                        ),
                        actions: [
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    controller.virtualZone == null
                                        ? CurrentAttendanceLocalSheet(
                                            title: controller.currentAttendance
                                                    .classroom?.courseName ??
                                                "Chamada",
                                          )
                                        : CurrentAttendanceVirtualZoneSheet(
                                            title: controller.currentAttendance
                                                    .classroom?.courseName ??
                                                "Chamada",
                                          ),
                              );
                            },
                            icon: const Icon(
                              key: Key('map outlined icon'),
                              Icons.map_outlined,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  icon:
                                      const Icon(Icons.warning_amber_outlined),
                                  title: const Text("FINALIZAR CHAMADA"),
                                  content: const Text(
                                    "Ao confirmar, sua chamada será finalizada e poderá ser acessada navegando em turmas.",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text("Cancelar"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Get.back();
                                        if (await controller.endAttendance()) {
                                          Get.offAllNamed(AppRoutes.home);
                                          Get.snackbar(
                                            "Chamada",
                                            "Chamada finalizada com sucesso!",
                                            snackPosition: SnackPosition.BOTTOM,
                                          );
                                        } else {
                                          Get.snackbar(
                                            "Erro",
                                            "Não foi possível finalizar a chamada",
                                            snackPosition: SnackPosition.BOTTOM,
                                          );
                                        }
                                      },
                                      child: const Text(
                                        "Confirmar",
                                        style: TextStyle(
                                          color: AppColors.red1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(
                              key: Key('close roll call'),
                              Icons.close_outlined,
                            ),
                          ),
                        ],
                      ),
                body: controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const CustomScrollView(
                        slivers: [
                          CurrentAttendanceTitleBar(),
                          CurrentAttendanceSearchBar(),
                          CurrentAttendanceStudentList(),
                        ],
                      ),
                bottomNavigationBar: const BottomNavBar(),
                floatingActionButton: FloatingActionButton.small(
                  key: const Key('add student icon'),
                  backgroundColor: AppColors.surfaceContainerHigh,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => GestureDetector(
                        onTap: () =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        child: AlertDialog(
                          icon: const Icon(Icons.add_outlined),
                          title: const Text("Adicione um aluno"),
                          content: SingleChildScrollView(
                            child: Form(
                              key: controller.formKey,
                              child: Column(
                                children: [
                                  const Text(
                                    "Essa ação realizará a criação de um aluno nessa chamada, você estará automaticamente marcando presença validada no mesmo.",
                                  ),
                                  const Spacing(8.0),
                                  TextFormField(
                                    key: const Key('student name add form'),
                                    validator: (val) => controller.validator
                                        .validateNotNullInput(val),
                                    controller: controller.nameController,
                                    decoration: const InputDecoration(
                                      labelText: "Nome completo do aluno",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacing(4.0),
                                  TextFormField(
                                    key:
                                        const Key('registration name add form'),
                                    validator: (val) => controller.validator
                                        .validateRegistration(val),
                                    controller:
                                        controller.registrationController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      controller.mask.registration
                                    ],
                                    decoration: const InputDecoration(
                                      labelText: "Matrícula",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("Cancelar"),
                            ),
                            TextButton(
                              onPressed: () async {
                                if (!controller.formKey.currentState!
                                    .validate()) return;
                                await controller.addStudent();
                                Get.back();
                                Get.snackbar(
                                  "Adicionar aluno",
                                  "Aluno adicionado com sucesso!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: const EdgeInsets.all(88.0),
                                );
                              },
                              child: const Text("Adicionar"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
