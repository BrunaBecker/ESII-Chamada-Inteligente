import 'package:flutter/material.dart';

import '../../core/widgets/bottom_nav_bar.dart';

class ClassesWidget extends StatelessWidget {
  const ClassesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const Text("Página das turmas"),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
