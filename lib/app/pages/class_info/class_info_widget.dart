import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/classes_drawer.dart';
import '../../core/widgets/profile_picture_button.dart';
import 'class_info_controller.dart';
import 'widgets/attendances_tab.dart';
import 'widgets/stats_tab.dart';
import 'widgets/students_tab.dart';

class ClassInfoWidget extends StatelessWidget {
  const ClassInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<ClassInfoController>(),
      builder: (controller) => Obx(
        () => DefaultTabController(
          length: 3,
          child: Scaffold(
            drawer: const ClassesDrawer(),
            appBar: controller.isLoading
                ? null
                : AppBar(
                    backgroundColor: AppColors.surfaceContainer,
                    title: Text(
                      controller.selectedClass["name"]!,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    centerTitle: true,
                    actions: const [
                      ProfilePictureButton(),
                    ],
                    bottom: const TabBar(
                      tabs: [
                        Tab(
                          icon: Icon(
                            Icons.note_alt_outlined,
                          ),
                          text: "Chamadas",
                          iconMargin: EdgeInsets.zero,
                        ),
                        Tab(
                          icon: Icon(
                            Icons.supervisor_account_outlined,
                          ),
                          text: "Meus alunos",
                          iconMargin: EdgeInsets.zero,
                        ),
                        Tab(
                          icon: Icon(
                            Icons.equalizer_outlined,
                          ),
                          text: "Estatísticas",
                          iconMargin: EdgeInsets.zero,
                        )
                      ],
                    ),
                  ),
            body: const TabBarView(
              children: [
                AttendancesTab(),
                StudentsTab(),
                StatsTab(),
              ],
            ),
            bottomNavigationBar: const BottomNavBar(),
          ),
        ),
      ),
    );
  }
}
