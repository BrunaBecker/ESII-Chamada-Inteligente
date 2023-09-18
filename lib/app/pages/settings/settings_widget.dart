import 'package:flutter/material.dart';

import '../../core/widgets/bottom_nav_bar.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const Text("Página das preferências"),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
