import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/spacing.dart';
import '../home_controller.dart';

class LocationText extends StatelessWidget {
  const LocationText({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: Get.find<HomeController>(),
      builder: (controller) => Obx(
        () => controller.virtualZone != null
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
                      "${controller.address ?? "-"}\n"
                      "Latitude: ${controller.location?.coordinate?.latitude ?? "-"}\n"
                      "Longitude: ${controller.location?.coordinate?.longitude ?? "-"}",
                    ),
                  ),
                  const Spacing(4.0),
                ],
              )
            : Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  "A chamada não possui localização definida.",
                ),
              ),
      ),
    );
  }
}
