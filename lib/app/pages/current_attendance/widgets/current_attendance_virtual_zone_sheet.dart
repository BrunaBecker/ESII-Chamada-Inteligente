import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../current_attendance_controller.dart';

class CurrentAttendanceVirtualZoneSheet extends StatelessWidget {
  const CurrentAttendanceVirtualZoneSheet({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrentAttendanceController>(
      init: Get.find<CurrentAttendanceController>(),
      builder: (controller) => Obx(
        () => controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.online_prediction_outlined,
                          color: AppColors.green1,
                        ),
                        title: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: const Text(
                          "Chamada online ocorrendo",
                        ),
                      ),
                      // TODO: gps
                      Container(
                        height: 150,
                        color: AppColors.lightGray,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Localização da zona virtual",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(controller.address),
                            Text(
                              "Latitude: ${controller.coordinate?.latitude ?? "-"}",
                            ),
                            Text(
                              "Longitude: ${controller.coordinate?.longitude ?? "-"}",
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              alignment: Alignment.centerRight,
                              child: const Text(
                                "A localização pode não ser precisa.",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: FilledButton(
                                onPressed: () => controller.fetch(),
                                child: const IntrinsicWidth(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.sync_alt_outlined,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        "Atualizar",
                                        style: TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ],
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
      ),
    );
  }
}
