import 'package:flutter/material.dart';

import 'attendance_filter_item.dart';

class AttendanceFilterOptions extends StatelessWidget {
  const AttendanceFilterOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        AttendanceFilterItem(
          label: "Filtrar",
          leading: Icons.filter_alt_outlined,
          onTap: () {},
          initialTab: 0,
        ),
        AttendanceFilterItem(
          label: "Exportar",
          leading: Icons.download_outlined,
          onTap: () {},
          initialTab: 1,
        ),
        AttendanceFilterItem(
          label: "Ordenar",
          leading: Icons.filter_alt_outlined,
          onTap: () {},
          initialTab: 2,
        ),
      ],
    );
  }
}
