import 'package:flutter/material.dart';
import '../../core/adapters/calendar_adapter.dart';
import '../../core/enums/event_status.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: CalendarAdapter(
            events: [
              {
                "startTime": DateTime.now().add(const Duration(hours: -6)),
                "endTime": DateTime.now().add(const Duration(hours: -4)),
                "class": "Engenharia de Software II",
                "status": EventStatus.classNormal,
                "color": AppColors.green1,
              },
              {
                "startTime": DateTime.now().add(const Duration(hours: -6)),
                "endTime": DateTime.now().add(const Duration(hours: -4)),
                "class": "Redes de Computadores II",
                "status": EventStatus.classCancelled,
                "color": AppColors.redDarker,
              },
              {
                "startTime": DateTime.now().add(const Duration(hours: -6)),
                "endTime": DateTime.now().add(const Duration(hours: -4)),
                "class": "Lógica Para Ciência da Computação",
                "status": EventStatus.classNormalRecurrent,
                "color": AppColors.orange,
              },
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}
