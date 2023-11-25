import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'spacing.dart';
import '../../pages/login/widgets/decorations/login_input_decoration.dart';

class WaiverCreationDialog extends StatelessWidget {
  const WaiverCreationDialog({
    super.key,
    required this.formKey,
    required this.waiverNameValidator,
    required this.waiverFileNameController,
    required this.waiverTitleValidator,
    required this.waiverTitleController,
    required this.waiverDescriptionValidator,
    required this.waiverDescriptionController,
    required this.onFileSelection,
    required this.onWaiverCreation,
  });

  final GlobalKey<FormState> formKey;
  final String? Function(String?) waiverNameValidator;
  final TextEditingController waiverFileNameController;
  final String? Function(String?) waiverTitleValidator;
  final TextEditingController waiverTitleController;
  final String? Function(String?) waiverDescriptionValidator;
  final TextEditingController waiverDescriptionController;
  final Function() onFileSelection;
  final Function() onWaiverCreation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: AlertDialog(
        title: const Text("Adicionar atestado"),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Informe ao seu professor sobre sua ausência justificada.",
                ),
                const Spacing(8.0),
                TextFormField(
                  validator: (val) => waiverNameValidator(val),
                  controller: waiverFileNameController,
                  readOnly: true,
                  decoration: LoginInputDecoration(
                    labelText: "Atestado",
                    hintText: "Insira o atestado",
                    suffixIcon: IconButton(
                      onPressed: onFileSelection,
                      icon: const Icon(
                        Icons.upload_file_outlined,
                      ),
                    ),
                  ),
                ),
                const Spacing(8.0),
                TextFormField(
                  validator: (val) => waiverTitleValidator(val),
                  controller: waiverTitleController,
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
                  validator: (val) => waiverDescriptionValidator(val),
                  controller: waiverDescriptionController,
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
              if (!formKey.currentState!.validate()) return;
              onWaiverCreation();
            },
            child: const Text("Enviar"),
          ),
        ],
      ),
    );
  }
}
