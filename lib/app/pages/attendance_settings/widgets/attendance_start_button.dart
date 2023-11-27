import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_routes.dart';
import '../attendance_settings_controller.dart';

class AttendanceStartButton extends StatelessWidget {
  const AttendanceStartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<AttendanceSettingsController>(),
      builder: (controller) {
        return FilledButton(
          onPressed: () {
            if (!controller.formKey.currentState!.validate()) return;
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("INICIANDO CHAMADA"),
                  content: const Text(
                    "Você realmente deseja iniciar uma chamada inteligente?",
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
                        Get.back();
                        final attendance = await controller.startAttendance();

                        if (attendance == null) {
                          Get.snackbar(
                            "Erro",
                            "Não foi possível iniciar a chamada!",
                            snackPosition: SnackPosition.BOTTOM,
                            margin: const EdgeInsets.all(88.0),
                          );
                          return;
                        }

                        Get.snackbar(
                          "Chamada",
                          "Chamada iniciada com sucesso!",
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.all(88.0),
                        );
                        Get.offAllNamed(
                          AppRoutes.currentAttendance,
                          arguments: {
                            "currentAttendance": attendance,
                          },
                        );
                      },
                      child: const Text("Confirmar"),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text("Iniciar"),
        );
      },
    );
  }
}
