import 'package:flutter/material.dart';

class BottomNavBarItem extends StatelessWidget {
  const BottomNavBarItem({
    super.key,
    required this.selectedIcon,
    required this.icon,
    required this.label,
  });

  final IconData selectedIcon;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      selectedIcon: Icon(selectedIcon),
      icon: Icon(icon),
      label: label,
    );
  }
}
