import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class SettingsTitle extends StatelessWidget {
  const SettingsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: const Text(
        "Preferências",
        style: TextStyle(
          color: AppColors.black,
          fontFamily: "Quicksand",
          fontWeight: FontWeight.w700,
          fontSize: 32,
        ),
      ),
    );
  }
}
