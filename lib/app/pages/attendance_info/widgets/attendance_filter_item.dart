import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'attendance_info_bottom_sheet.dart';

class AttendanceFilterItem extends StatelessWidget {
  const AttendanceFilterItem({
    super.key,
    required this.label,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final String label;
  final IconData? leading;
  final IconData? trailing;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: OutlinedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return const AttendanceInfoBottomSheet();
              },
            );
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.all(8.0),
            ),
          ),
          child: Row(
            children: [
              leading != null
                  ? Icon(
                      leading,
                      color: AppColors.black,
                      size: 18,
                    )
                  : const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ),
              trailing != null
                  ? Icon(
                      trailing,
                      color: AppColors.black,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
