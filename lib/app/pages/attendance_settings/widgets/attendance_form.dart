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
                      key: const Key('dropdown-class'),
                      value: controller.selectedClass,
                      isExpanded: true,
                      items: controller.classList
                          .map(
                            (item) => DropdownMenuItem(
                              key: const Key('dropdown-select'),
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
                      key: const Key('date-form'),
                      validator: (val) =>
                          controller.validator.validateNotNullInput(val),
                      controller: controller.dateController,
                      keyboardType: TextInputType.datetime,
                      inputFormatters: [controller.mask.date],
                      readOnly: true,
                      decoration: AttendanceSettingsInputDecoration(
                        labelText: "Data",
                        suffixIcon: IconButton(
                          key: const Key('date-edit-button'),
                          onPressed: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 1),
                              lastDate: DateTime(DateTime.now().year + 1),
                            );

                            if (date != null) {
                              controller.changeDate(date);
                              controller.disableUsePreset();
                            }
                          },
                          icon: const Icon(Icons.edit_calendar_outlined),
                        ),
                      ),
                      onChanged: (value) {
                        controller.startTimeController.text = value;
                        controller.disableUsePreset();
                      },
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 4.0),
                        child: Text(
                          "DD/MM/YYYY",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                    const Spacing(8.0),
                    TextFormField(
                      validator: (val) =>
                          controller.validator.validateNotNullInput(val),
                      controller: controller.startTimeController,
                      keyboardType: TextInputType.datetime,
                      inputFormatters: [controller.mask.time],
                      readOnly: true,
                      decoration: AttendanceSettingsInputDecoration(
                        labelText: "Início",
                        hintText: "09:30",
                        suffixIcon: IconButton(
                          key: const Key('select start class button'),
                          onPressed: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            if (time != null) {
                              controller.changeStartTime(time);
                              controller.disableUsePreset();
                            }
                          },
                          icon: const Icon(Icons.access_time_outlined),
                        ),
                      ),
                      onChanged: (value) {
                        controller.startTimeController.text = value;
                        controller.disableUsePreset();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                      ),
                      child: Row(
                        children: [
                          Switch(
                            value: controller.manualEnd,
                            onChanged: (_) => controller.toggleManualEnd(),
                          ),
                          const Spacing(8.0),
                          const Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                "Finalizar a chamada manualmente",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    controller.manualEnd
                        ? const SizedBox()
                        : TextFormField(
                            validator: (val) =>
                                controller.validator.validateNotNullInput(val),
                            controller: controller.endTimeController,
                            keyboardType: TextInputType.datetime,
                            inputFormatters: [controller.mask.time],
                            readOnly: true,
                            decoration: AttendanceSettingsInputDecoration(
                              labelText: "Fim",
                              hintText: "11:30",
                              suffixIcon: IconButton(
                                key: const Key('select end class button'),
                                onPressed: () async {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );

                                  if (time != null) {
                                    controller.changeEndTime(time);
                                    controller.disableUsePreset();
                                  }
                                },
                                icon: const Icon(Icons.access_time_outlined),
                              ),
                            ),
                            onChanged: (value) {
                              controller.endTimeController.text = value;
                              controller.disableUsePreset();
                            },
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
                          const Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                "Salvar essa predefinição no calendário",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
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
