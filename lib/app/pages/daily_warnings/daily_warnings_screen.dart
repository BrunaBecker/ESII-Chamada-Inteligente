import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/enums/event_status.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_date_utils.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/event_info_dialog.dart';
import 'daily_warnings_controller.dart';

class DailyWarningsScreen extends StatelessWidget {
  const DailyWarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DailyWarningsController>(
      init: Get.find<DailyWarningsController>(),
      builder: (controller) => Obx(
        () => Scaffold(
          appBar: controller.isLoading
              ? null
              : AppBar(
                  title: Text(
                    "Avisos ${AppDateUtils.appDateFormat.format(controller.day)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
          body: Obx(
            () => controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: controller.events.length,
                    itemBuilder: (context, index) {
                      final event = controller.events[index];
                      final status = event.status;
                      return ListTile(
                        leading: Icon(
                          status == EventStatus.classNormal
                              ? Icons.check_outlined
                              : status == EventStatus.classCancelled
                                  ? Icons.close_outlined
                                  : Icons.schedule_outlined,
                          color: status == EventStatus.classNormal
                              ? AppColors.green1
                              : status == EventStatus.classCancelled
                                  ? AppColors.redDarker
                                  : AppColors.orange,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.classroom.code,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                            Text(event.classroom.courseName),
                          ],
                        ),
                        subtitle: Text(
                          event.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: const Icon(Icons.arrow_right_outlined),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => EventInfoDialog(
                              title: event.classroom.courseName,
                              description: event.description,
                              status: event.status,
                              center: false,
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
          bottomNavigationBar: const BottomNavBar(),
        ),
      ),
    );
  }
}
