import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/spacing.dart';
import 'notifications_controller.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              key: const Key('notification_button_pressed'),
              icon: const Icon(Icons.notifications),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
      body: GetBuilder(
        init: Get.find<NotificationsController>(),
        builder: (controller) => Obx(
          () => controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: controller.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = controller.notifications[index];
                    return ListTile(
                      key: const Key('notification list'),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      leading: IconButton(
                        onPressed: () {},
                        icon: Icon(notification["isRead"] ? Icons.notifications_outlined : Icons.notifications_active),
                      ),
                      title: Text(notification["title"]),
                      subtitle: Text(notification["description"]),
                      trailing: PopupMenuButton(
                        key: const Key('ellipsis menu'),
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            onTap: () => controller.toggleReadNotification(notification["id"]),
                            child: Row(
                              children: [
                                const Icon(Icons.cut),
                                const Spacing(4.0),
                                Text("Marcar como ${notification["isRead"] ? "não " : ""}lida"),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () => controller.removeNotification(notification["id"]),
                            child: const Row(
                              children: [
                                Icon(Icons.delete_outline),
                                Spacing(4.0),
                                Text("Excluir"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
