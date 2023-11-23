import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../enums/event_status.dart';
import '../theme/app_colors.dart';

class EventInfoDialog extends StatelessWidget {
  const EventInfoDialog({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    this.center = false,
  }) : color = status == EventStatus.classNormal
            ? AppColors.green1
            : status == EventStatus.classCancelled
                ? AppColors.redDarker
                : AppColors.orange;

  final String title;
  final String description;
  final EventStatus status;
  final Color color;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(
        status == EventStatus.classNormal
            ? Icons.check_outlined
            : status == EventStatus.classCancelled
                ? Icons.close_outlined
                : Icons.schedule_outlined,
        color: color,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color,
        ),
      ),
      content: Text(
        description,
        textAlign: center ? TextAlign.center : TextAlign.start,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Ok"),
        ),
      ],
    );
  }
}
