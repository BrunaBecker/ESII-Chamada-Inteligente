import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class CurrentAttendanceLocalSheet extends StatelessWidget {
  const CurrentAttendanceLocalSheet({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 128,
      child: Center(
        child: ListTile(
          leading: const Icon(
            Icons.online_prediction_outlined,
            color: AppColors.red1,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: const Text(
            "Chamada manual ocorrendo",
          ),
        ),
      ),
    );
  }
}
