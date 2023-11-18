import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/spacing.dart';
import '../login_controller.dart';

class LoginErrorPanel extends StatelessWidget {
  const LoginErrorPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: Get.find<LoginController>(),
      builder: (controller) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset(
                ImageAssets.loginErrorIcon,
                fit: BoxFit.contain,
              ),
            ),
            const Spacing(4.0),
            Text(
              controller.errorMessage,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                fontFeatures: [FontFeature.enable('smcp')],
              ),
              textAlign: TextAlign.center,
            ),
            const Spacing(4.0),
            FilledButton(
              onPressed: () => controller.toggleErrorScreen(),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_outlined,
                    size: 18,
                  ),
                  Spacing(4.0),
                  Text("VOLTAR"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
