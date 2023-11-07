import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../login_controller.dart';
import 'decorations/login_input_decoration.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: Get.find<LoginController>(),
      builder: (controller) => Form(
        key: controller.formKey,
        child: Column(
          children: [
            TextFormField(
              key: const Key('matrícula_form'),
              keyboardType: TextInputType.number,
              validator: (val) => controller.validator.validateRegistration(val),
              inputFormatters: [controller.mask.registration],
              decoration: LoginInputDecoration(
                labelText: "Matrícula/SIAPE",
                hintText: "Matrícula/SIAPE",
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
                child: Text(
                  "Matrícula SIAPE para docentes",
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8,
              ),
            ),
            Obx(
              () => TextFormField(
                validator: (val) => controller.validator.validateNotNullInput(val),
                key: const Key('senha_form'),
                decoration: LoginInputDecoration(
                  labelText: "Senha",
                  hintText: "Senha",
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.togglePasswordVisibility();
                    },
                    icon: Icon(
                      controller.isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: AppColors.black,
                    ),
                  ),
                ),
                obscureText: !controller.isVisible,
                obscuringCharacter: "●",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
