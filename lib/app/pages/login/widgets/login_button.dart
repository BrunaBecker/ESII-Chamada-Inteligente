import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_routes.dart';
import '../login_controller.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<LoginController>(),
      builder: (controller) => SizedBox(
        key: const Key('entrar_button'),
        width: double.maxFinite,
        child: FilledButton(
          onPressed: () async {
            if (!controller.formKey.currentState!.validate()) return;
            await controller.authenticateFromLogin();
            if (controller.appController.user != null) {
              Get.offAllNamed(AppRoutes.home);
            }
          },
          child: const Text("ENTRAR"),
        ),
      ),
    );
  }
}
