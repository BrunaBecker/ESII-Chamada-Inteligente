import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/profile_picture_button.dart';
import 'classes_controller.dart';

class ClassesWidget extends StatelessWidget {
  const ClassesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: const Text("Minhas turmas"),
        centerTitle: true,
        actions: const [
          ProfilePictureButton(),
        ],
      ),
      body: GetBuilder(
        init: Get.find<ClassesController>(),
        builder: (controller) => Obx(
          () => controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: controller.classesList.length,
                  itemBuilder: (context, index) {
                    final item = controller.classesList[index];
                    return ListTile(
                      onTap: () {},
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryContainer,
                        ),
                        child: Center(
                          child: Text(
                            item["class"]!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        item["code"]!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkGray,
                        ),
                      ),
                      subtitle: Text(
                        "${item["name"]} - ${item["class"]}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.onSurface,
                        ),
                      ),
                      trailing: const Icon(Icons.more_vert),
                    );
                  },
                ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
