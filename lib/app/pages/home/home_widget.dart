import 'package:flutter/material.dart';

import '../../core/widgets/bottom_nav_bar.dart';
import 'widgets/start_button.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const Center(
          child: StartButton(),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
