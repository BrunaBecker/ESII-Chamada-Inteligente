import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class AttendanceSettingsTitle extends StatelessWidget {
  const AttendanceSettingsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary30,
      alignment: Alignment.center,
      child: const Text(
        "CONFIGURE SUA CHAMADA",
        style: TextStyle(
          color: AppColors.white,
          fontFamily: "Quicksand",
          fontWeight: FontWeight.w600,
          fontSize: 32,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
