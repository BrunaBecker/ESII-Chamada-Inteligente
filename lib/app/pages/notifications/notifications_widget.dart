import 'package:flutter/material.dart';

import '../../core/widgets/bottom_nav_bar.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const Text("Página das notificações"),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
