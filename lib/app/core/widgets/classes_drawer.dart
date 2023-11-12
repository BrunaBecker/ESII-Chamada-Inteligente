import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';
import 'spacing.dart';
import '../../pages/classes/classes_controller.dart';

class ClassesDrawer extends StatelessWidget {
  const ClassesDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder(
        init: Get.find<ClassesController>(),
        builder: (controller) => Drawer(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 24.0,
              left: 24.0,
              right: 24.0,
              bottom: 0.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "MAC-FI",
                  style: TextStyle(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: const Divider(),
                ),
                const Text(
                  "Turmas",
                  style: TextStyle(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacing(8.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.classesList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == controller.classesList.length) {
                        return const Divider();
                      }

                      final item = controller.classesList[index];
                      return ListTile(
                        key: const Key('drawer class tile'),
                        onTap: () {
                          controller.toggleAttendance(index);
                          debugPrint(item["activeAttendance"].toString());
                        },
                        contentPadding: EdgeInsets.zero,
                        horizontalTitleGap: 0,
                        leading: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: item["activeAttendance"]!
                                ? AppColors.green1
                                : AppColors.onSurfaceVariant,
                          ),
                        ),
                        title: Text(
                          item["name"]!,
                          style: const TextStyle(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          item["class"],
                        ),
                      );
                    },
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
