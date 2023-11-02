import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_routes.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../notifications/notifications_controller.dart';
import 'widgets/start_button.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GetBuilder(
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
        child: const Center(
          child: StartButton(),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
