import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../settings_controller.dart';
import 'option_card.dart';
import 'option_item.dart';

class SettingsOptions extends StatelessWidget {
  const SettingsOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<SettingsController>(),
      builder: (controller) => Obx(
        () => controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Column(
                      children: [
                        OptionItem(
                          value: controller.usePreset,
                          onChanged: (_) => controller.toggleUsePreset(),
                          text:
                              "Usar a predefinição do calendário para as chamadas",
                        ),
                        OptionItem(
                          value: controller.saveLocation,
                          onChanged: (_) => controller.toggleSaveLocation(),
                          text:
                              "Salvar automaticamente minha localização a cada nova chamada",
                        ),
                        OptionItem(
                          value: controller.silentMode,
                          onChanged: (_) => controller.toggleSilentMode(),
                          text: "Silenciar notificações",
                        ),
                        OptionCard(
                          title: "Minhas localizações",
                          subtitle:
                              "Supporting line text lorem ipsum dolor sit amet, consectetur.",
                          leadingIcon: const Icon(Icons.map_outlined),
                          trailingIcon: const Icon(Icons.arrow_right),
                          onTap: () {},
                        ),
                        OptionCard(
                          title: "Tema",
                          subtitle:
                              "Supporting line text lorem ipsum dolor sit amet, consectetur.",
                          leadingIcon: const Icon(Icons.dark_mode_outlined),
                          onTap: () {},
                        ),
                        OptionCard(
                          title: "Ajuda",
                          subtitle:
                              "Ajuda, sobre o aplicativo, política de privacidade.",
                          leadingIcon: const Icon(Icons.help_outline_outlined),
                          trailingIcon: const Icon(Icons.arrow_right),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
