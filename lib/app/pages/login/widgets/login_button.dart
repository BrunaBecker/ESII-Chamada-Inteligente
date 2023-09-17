import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_routes.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: FilledButton(
        onPressed: () {
          // TODO: validate form and authentication

          Get.offAllNamed(AppRoutes.home);
        },
        child: const Text("ENTRAR"),
      ),
    );
  }
}
