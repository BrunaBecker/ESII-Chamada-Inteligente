import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_routes.dart';
import '../../../core/theme/app_colors.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Get.offAllNamed(AppRoutes.attendanceSettings);
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: AppColors.primary,
          ),
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.all(4),
              ),
              Icon(
                Icons.power_settings_new,
                size: 160,
                color: AppColors.white,
              ),
              Text(
                "INICIAR CHAMADA",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
