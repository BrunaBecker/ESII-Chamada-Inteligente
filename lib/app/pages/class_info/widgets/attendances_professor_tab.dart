import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_date_utils.dart';
import '../../../core/widgets/spacing.dart';
import '../class_info_controller.dart';

class AttendancesProfessorTab extends StatelessWidget {
  const AttendancesProfessorTab({super.key});

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
                      SizedBox(
                        width: double.maxFinite,
                        child: FilledButton.icon(
                          key: const Key('filter by date button'),
                          onPressed: () async {
                            // TODO: refactor dates
                            controller.selectedDateRange =
                                await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(2023, 11, 1),
                              lastDate: DateTime.now(),
                            );
                          },
                          icon: const Icon(Icons.date_range_outlined),
                          label: const Text("Filtrar por data"),
                        ),
                      ),
                      const Spacing(8.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Total de chamadas: ${controller.attendances.length}",
                          style: const TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: controller.attendances.length,
                          itemBuilder: (context, index) {
                            final item = controller.attendances[index];
                            return ListTile(
                              title: Text(
                                AppDateUtils.appDateFormat.format(item.date),
                              ),
                              subtitle: Text(item.supportingText),
                              trailing: IconButton(
                                icon: const Icon(
                                  key: Key('edit roll call button'),
                                  Icons.mode_edit_outline_outlined,
                                ),
                                onPressed: () {
                                  Get.toNamed(
                                    AppRoutes.attendanceInfo,
                                    arguments: {
                                      "attendanceInfo": item,
                                    },
                                  );
                                },
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 16.0,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 1,
                            child: Divider(),
                          ),
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
