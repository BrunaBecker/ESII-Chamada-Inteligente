import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_routes.dart';
import '../../core/adapters/calendar_adapter.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_date_utils.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import 'calendar_controller.dart';
import 'widgets/event_form_dialog.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<CalendarController>(
          init: Get.find<CalendarController>(),
          builder: (controller) => Scaffold(
            body: Obx(
              () => controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 500,
                              child: CalendarAdapter(
                                onSelectionChanged: (calendarSelectionDetails) {
                                  if (calendarSelectionDetails.date == null) {
                                    return;
                                  }
                                  controller.changeDate(
                                    calendarSelectionDetails.date!,
                                  );
                                },
                                onViewChanged: (viewChangedDetails) async {
                                  if (controller.skipDate) {
                                    controller.skipDate = false;
                                    return;
                                  }
                                  controller.fetchEvents(
                                    start:
                                        viewChangedDetails.visibleDates.first,
                                    end: viewChangedDetails.visibleDates.last,
                                  );
                                },
                                events: controller.events,
                              ),
                            ),
                            controller.selectedDate != null
                                ? ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Avisos",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.onSurfaceVariant,
                                          ),
                                        ),
                                        Text(
                                          AppDateUtils.appDateFormat
                                              .format(controller.selectedDate!),
                                          style: const TextStyle(
                                              color: AppColors.onSurface),
                                        ),
                                      ],
                                    ),
                                    subtitle: Obx(
                                      () => controller
                                              .selectedDayEvents.isNotEmpty
                                          ? const Text(
                                              "Ver avisos sobre as aulas do dia selecionado.")
                                          : const Text(
                                              "Nenhum aviso para o dia selecionado."),
                                    ),
                                    leading: const Icon(Icons.calendar_today),
                                    onTap: () {
                                      if (controller
                                          .selectedDayEvents.isNotEmpty) {
                                        Get.toNamed(
                                          AppRoutes.dailyWarnings,
                                          arguments: {
                                            "day": controller.selectedDate,
                                            "events":
                                                controller.selectedDayEvents,
                                          },
                                        );
                                      }
                                    },
                                  )
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 28.0,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Selecione uma data para ver os avisos.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
            ),
            floatingActionButton: FloatingActionButton.small(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const EventFormDialog(),
                );
              },
              backgroundColor: AppColors.surfaceContainerHigh,
              child: const Icon(
                Icons.add,
                color: AppColors.primary,
              ),
            ),
            bottomNavigationBar: const BottomNavBar(),
          ),
        ),
      ),
    );
  }
}
