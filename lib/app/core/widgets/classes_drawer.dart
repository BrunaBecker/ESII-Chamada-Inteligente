import 'package:flutter/material.dart';

import '../domain/entities/classroom_entity.dart';
import '../theme/app_colors.dart';
import 'spacing.dart';

class ClassesDrawer extends StatelessWidget {
  const ClassesDrawer({
    super.key,
    required this.classrooms,
    this.activeAttendanceClassroomId,
  });

  final List<ClassroomEntity> classrooms;
  final int? activeAttendanceClassroomId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
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
                  itemCount: classrooms.length + 1,
                  itemBuilder: (context, index) {
                    if (index == classrooms.length) {
                      return const Divider();
                    }

                    final item = classrooms[index];
                    return ListTile(
                      key: const Key('drawer class tile'),
                      onTap: () {},
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 0,
                      leading: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: item.id == activeAttendanceClassroomId
                              ? AppColors.green1
                              : AppColors.onSurfaceVariant,
                        ),
                      ),
                      title: Text(
                        item.courseName,
                        style: const TextStyle(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        item.className,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
