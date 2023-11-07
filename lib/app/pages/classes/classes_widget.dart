import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/profile_picture_button.dart';
import 'classes_controller.dart';
import '../../core/widgets/classes_drawer.dart';

class ClassesWidget extends StatelessWidget {
  const ClassesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ClassesDrawer(),
      appBar: AppBar(
        key: const Key('class_page_header'),
        title: const Text("Minhas turmas"),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: ProfilePictureButton(),
          ),
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
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.only(left: 16.0),
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
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: PopupMenuButton(
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              onTap: () {},
                              child: const ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  "Iniciar Chamada",
                                ),
                                subtitle: Text(
                                  "Comece uma chamada",
                                ),
                                trailing: Icon(Icons.arrow_right),
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () => Get.toNamed(
                                AppRoutes.classInfo,
                                arguments: {
                                  "classInfo": item,
                                },
                              ),
                              child: const ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  "Ver mais",
                                ),
                                subtitle: Text(
                                  "Interaja com a turma",
                                ),
                                trailing: Icon(Icons.arrow_right),
                              ),
                            ),
                          ],
                        ),
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
