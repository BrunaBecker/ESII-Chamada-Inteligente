import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/spacing.dart';
import '../attendance_settings_controller.dart';
import 'decorations/attendance_settings_input_decoration.dart';

class AttendanceForm extends StatelessWidget {
  const AttendanceForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<AttendanceSettingsController>(),
      builder: (controller) => Form(
        key: controller.formKey,
        child: Obx(
          () => controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    DropdownButtonFormField(
                      isExpanded: true,
                      items: controller.classList
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        controller.changeClass(value ?? "");
                      },
                      decoration: AttendanceSettingsInputDecoration(
                        labelText: "Turma",
                        prefixIcon: const Icon(Icons.search),
                      ),
                      dropdownColor: AppColors.surfaceContainer,
                    ),
                    const Spacing(8.0),
                    TextFormField(
                      controller: controller.startTimeController,
                      keyboardType: TextInputType.datetime,
                      decoration: AttendanceSettingsInputDecoration(
                        labelText: "Início",
                        hintText: "09:30",
                        prefixIcon: const Icon(Icons.access_time),
                      ),
                    ),
                    const Spacing(4.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Switch(
                            value: controller.manualEnd,
                            onChanged: (_) => controller.toggleManualEnd(),
                          ),
                          const Spacing(8.0),
                          const Text(
                            "Finalizar a chamada manualmente",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    controller.manualEnd
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: controller.endTimeController,
                              keyboardType: TextInputType.datetime,
                              decoration: AttendanceSettingsInputDecoration(
                                labelText: "Fim",
                                hintText: "11:30",
                                prefixIcon: const Icon(Icons.access_time),
                              ),
                            ),
                          ),
                    const Spacing(4.0),
                    SingleChildScrollView(
                      child: Row(
                        children: [
                          Checkbox(
                            value: controller.saveSettings,
                            onChanged: (_) => controller.toggleSaveSettings(),
                          ),
                          const Spacing(8.0),
                          const Text(
                            "Salvar essa predefinição no calendário",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
