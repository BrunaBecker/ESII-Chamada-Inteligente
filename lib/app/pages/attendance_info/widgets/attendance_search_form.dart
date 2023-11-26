import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../attendance_info_controller.dart';

class AttendanceSearchForm extends StatelessWidget {
  const AttendanceSearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<AttendanceInfoController>(),
      builder: (controller) => TextFormField(
        onChanged: (_) {
          controller.search();
        },
        controller: controller.searchController,
        decoration: InputDecoration(
          hintText: "Pesquise algum aluno",
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.search_outlined,
            ),
            onPressed: () {
              controller.search();
            },
          ),
          filled: true,
          fillColor: AppColors.surfaceContainerHigh,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28.0),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
