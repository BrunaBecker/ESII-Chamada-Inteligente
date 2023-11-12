import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enums/event_status.dart';
import '../../../core/utils/app_date_utils.dart';
import '../../../core/widgets/spacing.dart';
import '../../login/widgets/decorations/login_input_decoration.dart';
import '../calendar_controller.dart';

class EventFormDialog extends StatelessWidget {
  const EventFormDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarController>(
      init: Get.find<CalendarController>(),
      builder: (controller) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: controller.selectedDate == null
            ? AlertDialog(
                title: const Text(
                  "Nenhuma data selecionada",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                content: const Text("Por favor, selecione uma data para criar um novo evento."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Ok"),
                  ),
                ],
              )
            : AlertDialog(
                title: Text(
                  AppDateUtils.appDateFormat.format(controller.selectedDate!),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                content: IntrinsicHeight(
                  child: Column(
                    children: [
                      const Text(
                        "Novo evento para a turma. Indique a turma, o tipo de evento e descreva-o.",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: controller.classNameController,
                                decoration: LoginInputDecoration(
                                  labelText: "Turma",
                                  hintText: "Informe a turma",
                                ),
                              ),
                              const Spacing(8.0),
                              SizedBox(
                                child: DropdownButtonFormField(
                                  onChanged: (value) {
                                    controller.eventController.text = value!.toLongText();
                                  },
                                  items: List.generate(
                                    EventStatus.values.length,
                                    (index) => DropdownMenuItem(
                                      value: EventStatus.values[index],
                                      child: SizedBox(
                                        width: 200,
                                        child: Text(
                                          EventStatus.values[index].toLongText(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  icon: const SizedBox.shrink(),
                                  decoration: LoginInputDecoration(
                                    labelText: "Tipo de Evento",
                                    hintText: "Informe o tipo de evento",
                                    suffixIcon: const Icon(Icons.arrow_drop_down_outlined),
                                  ),
                                ),
                              ),
                              const Spacing(8.0),
                              TextFormField(
                                controller: controller.commentController,
                                decoration: LoginInputDecoration(
                                  labelText: "Comentário",
                                  hintText: "Comente sobre esse evento",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                      if (!controller.formKey.currentState!.validate()) return;
                      controller.saveEvent();
                      Get.back();
                    },
                    child: const Text("Confirmar"),
                  ),
                ],
              ),
      ),
    );
  }
}
