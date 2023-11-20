import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/profile_picture.dart';
import '../../core/widgets/spacing.dart';
import 'profile_controller.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              key: const Key('sair_box'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      icon: const Icon(Icons.logout_outlined),
                      title: const Text("Sair do aplicativo"),
                      content: const Text(
                          "Essa ação irá desconectar a sessão salva na aplicação e você terá que entrar novamente."),
                      actions: [
                        TextButton(
                          key: const Key('cancelar_logout_button'),
                          onPressed: () => Get.back(),
                          child: const Text("Cancelar"),
                        ),
                        TextButton(
                          key: const Key('confirmar_logout_button'),
                          onPressed: () {
                            controller.logout();
                            Get.offAllNamed(AppRoutes.login);
                          },
                          child: const Text("Confirmar"),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.logout_outlined),
              color: AppColors.black,
            ),
          ],
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: GetBuilder(
            init: Get.find<ProfileController>(),
            builder: (controller) => Obx(
              () => controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.user == null
                      ? const Center(
                          child: Text(
                            "Não foi possível recuperar as informações do usuário",
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 256,
                                height: 256,
                                child: ProfilePicture(
                                  imageUrl: controller.profileImage,
                                ),
                              ),
                              const Spacing(8.0),
                              Text(
                                controller.user!.name,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "${controller.isProfessor ? "SIAPE" : "Matrícula"}: ${controller.user!.register.identifier}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.email_outlined),
                                  const Spacing(2.0),
                                  Flexible(
                                    child: Text(
                                      controller.user!.email,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}
