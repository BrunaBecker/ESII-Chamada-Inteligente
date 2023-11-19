import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/spacing.dart';
import '../../login/widgets/decorations/login_input_decoration.dart';
import '../class_info_controller.dart';

class JustificationDialog extends StatelessWidget {
  const JustificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetBuilder<ClassInfoController>(
        init: Get.find<ClassInfoController>(),
        builder: (controller) => Obx(
          () => controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : AlertDialog(
                  title: const Text("Adicionar atestado"),
                  content: SingleChildScrollView(
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Informe ao seu professor sobre sua ausência justificada.",
                          ),
                          const Spacing(8.0),
                          TextFormField(
                            validator: (val) =>
                                controller.validator.validateNotNullInput(val),
                            controller:
                                controller.justificationFileNameController,
                            readOnly: true,
                            decoration: LoginInputDecoration(
                              labelText: "Atestado",
                              hintText: "Insira o atestado",
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.upload_file_outlined,
                                ),
                              ),
                            ),
                          ),
                          const Spacing(8.0),
                          TextFormField(
                            validator: (val) =>
                                controller.validator.validateNotNullInput(val),
                            controller: controller.justificationTitleController,
                            decoration: LoginInputDecoration(
                              labelText: "Título",
                              hintText: "Insira o título",
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(
                              top: 4.0,
                              left: 16.0,
                              bottom: 16.0,
                            ),
                            child: const Text(
                              "Até 40 caracteres",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller:
                                controller.justificationDescriptionController,
                            decoration: LoginInputDecoration(
                              labelText: "Descrição",
                              hintText: "Insira a descrição",
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(
                              top: 4.0,
                              left: 16.0,
                            ),
                            child: const Text(
                              "Até 300 caracteres",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Cancelar"),
                    ),
                    TextButton(
                      onPressed: () {
                        if (!controller.formKey.currentState!.validate())
                          return;
                      },
                      child: const Text("Enviar"),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
