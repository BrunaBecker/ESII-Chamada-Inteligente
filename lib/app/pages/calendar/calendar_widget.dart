import 'package:flutter/material.dart';

import '../../core/widgets/bottom_nav_bar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const Text("Página do calendário"),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
