import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_routes.dart';
import 'bottom_nav_bar_item.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  static int getPageIndex(String page) {
    switch (page) {
      case AppRoutes.home:
        return 0;
      case AppRoutes.classes ||
            AppRoutes.classInfo ||
            AppRoutes.attendanceInfo ||
            AppRoutes.studentInfo:
        return 1;
      case AppRoutes.calendar:
        return 2;
      case AppRoutes.settings:
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      animationDuration: const Duration(milliseconds: 0),
      selectedIndex: getPageIndex(Get.currentRoute),
      destinations: const [
        BottomNavBarItem(
          key: Key('início_button'),
          selectedIcon: Icons.home,
          icon: Icons.home_outlined,
          label: "Início",
        ),
        BottomNavBarItem(
          key: Key('turmas_button'),
          selectedIcon: Icons.class_,
          icon: Icons.class_outlined,
          label: "Turmas",
        ),
        BottomNavBarItem(
          key: Key('calendário_button'),
          selectedIcon: Icons.calendar_month,
          icon: Icons.calendar_month_outlined,
          label: "Calendário",
        ),
        BottomNavBarItem(
          key: Key('preferências_button'),
          selectedIcon: Icons.settings,
          icon: Icons.settings_outlined,
          label: "Preferências",
        ),
      ],
      onDestinationSelected: (index) {
        var route = AppRoutes.home;
        switch (index) {
          case 0:
            route = AppRoutes.home;
            break;
          case 1:
            route = AppRoutes.classes;
            break;
          case 2:
            route = AppRoutes.calendar;
            break;
          case 3:
            route = AppRoutes.settings;
            break;
          default:
            break;
        }
        Get.offAllNamed(route);
      },
    );
  }
}
