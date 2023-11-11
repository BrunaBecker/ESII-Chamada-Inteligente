import 'package:flutter/material.dart';
import '../../core/adapters/calendar_adapter.dart';
import '../../core/enums/event_status.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/spacing.dart';
import 'widgets/event_form_dialog.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Expanded(
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
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                      ),
                      Spacing(4.0),
                      Text(
                        "Avisos",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const EventFormDialog(),
            );
          },
          backgroundColor: AppColors.surfaceContainerHigh,
          child: const Icon(
            Icons.add,
            color: AppColors.primary,
          ),
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}
