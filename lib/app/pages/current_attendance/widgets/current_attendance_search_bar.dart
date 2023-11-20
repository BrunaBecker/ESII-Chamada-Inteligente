import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../current_attendance_controller.dart';

class CurrentAttendanceSearchBar extends StatelessWidget {
  const CurrentAttendanceSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CurrentAttendanceController>(),
      builder: (controller) => SliverAppBar(
        flexibleSpace: Column(
          children: [
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(28.0),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Pesquise algum aluno",
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu_outlined,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search_outlined,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Text(
              key: const Key('number of students answer'),
              "De ${controller.totalStudents()} alunos, ${controller.answeredStudents()} responderam essa chamada",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        toolbarHeight: 100,
        expandedHeight: 100,
        collapsedHeight: 100,
        pinned: true,
      ),
    );
  }
}
