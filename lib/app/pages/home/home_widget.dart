import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../app_routes.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../notifications/notifications_controller.dart';
import 'home_controller.dart';
import 'widgets/home_attendance_panel.dart';
import 'widgets/start_button.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: Get.find<HomeController>(),
      builder: (controller) => Obx(
        () => controller.isLoading
            ? Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: controller.userType != UserType.professor
                      ? const Text(
                          "Chamada Inteligente",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Quicksand",
                          ),
                        )
                      : const Text(""),
                  actions: [
                    GetBuilder(
                      key: const Key('notification_button'),
                      init: Get.find<NotificationsController>(),
                      builder: (controller) => GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.notifications),
                        child: Stack(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              padding: const EdgeInsets.only(right: 16.0),
                              child: const Icon(Icons.notifications_outlined),
                            ),
                            Obx(
                              () => controller.isLoading || controller.totalUnreadNotifications < 1
                                  ? const SizedBox()
                                  : Positioned(
                                      top: 12,
                                      left: 24,
                                      child: Badge(
                                        smallSize: 16,
                                        largeSize: 16,
                                        label: Text(controller.totalUnreadNotifications.toString()),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                body: Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: Get.find<AppController>().userType == UserType.professor ? const StartButton() : const HomeAttendancePanel(),
                  ),
                ),
                bottomNavigationBar: const BottomNavBar(),
              ),
      ),
    );
  }
}
