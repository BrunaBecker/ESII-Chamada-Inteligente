import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../home_controller.dart';

class HomeAttendancePanel extends StatelessWidget {
  const HomeAttendancePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: Get.find<HomeController>(),
      builder: (controller) => Obx(
        () => controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.attendance == null
                ? const Center(
                    child: Text("Você não possui uma chamada em andamento."),
                  )
                : Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          const Text("Registre sua presença!"),
                          AlertDialog(
                            insetPadding: const EdgeInsets.all(16.0),
                            contentPadding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: const BorderSide(
                                width: 1,
                                color: AppColors.outlineVariant,
                              ),
                            ),
                            content: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: AppColors.primary,
                                    child: Text(
                                      controller.attendance!["name"],
                                      style: const TextStyle(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    controller.attendance!["class"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Text(
                                    controller.attendance!["code"],
                                  ),
                                  trailing: Icon(
                                    Icons.online_prediction_outlined,
                                    color: controller.hasAttendance ? AppColors.red1 : AppColors.green1,
                                  ),
                                ),
                                controller.hasAttendance
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 150,
                                            color: AppColors.lightGray,
                                          ),
                                          const ListTile(
                                            title: Text(
                                              "Localização da zona virtual",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            subtitle: Text(
                                              "A localização pode não ser precisa.",
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            subtitle: Text(
                                              "${controller.attendance!["address"]}\n"
                                              "Latitude: ${controller.attendance!["latitude"]}\n"
                                              "Longitude: ${controller.attendance!["longitude"]}",
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Text("A chamada não possui localização definida."),
                              ],
                            ),
                            actions: [
                              OutlinedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                ),
                                child: const IntrinsicWidth(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Icon(
                                          Icons.arrow_drop_down_outlined,
                                          size: 18,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Text("Falta"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              FilledButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                ),
                                child: const IntrinsicWidth(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Icon(
                                          Icons.check_outlined,
                                          size: 18,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Text("Presente"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
