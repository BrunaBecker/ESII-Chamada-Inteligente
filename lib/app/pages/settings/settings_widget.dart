import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/widgets/bottom_nav_bar.dart';
import 'settings_controller.dart';
import 'widgets/settings_options.dart';
import 'widgets/settings_title.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder(
            init: Get.find<SettingsController>(),
            builder: (controller) => Obx(
              () => controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          title: SettingsTitle(),
                          toolbarHeight: 135,
                          pinned: true,
                        ),
                        SliverToBoxAdapter(
                          child: SettingsOptions(),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}
