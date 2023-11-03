import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
          child: SfCalendar(
            view: CalendarView.month,
            firstDayOfWeek: 1,
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              showAgenda: true,
              monthCellStyle: MonthCellStyle(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  fontFamily: "Poppins",
                ),
                trailingDatesTextStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  fontFamily: "Poppins",
                ),
                leadingDatesTextStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  fontFamily: "Poppins",
                ),
              ),
            ),
            todayHighlightColor: AppColors.blue1,
            todayTextStyle: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w500,
              fontSize: 10,
              fontFamily: "Poppins",
            ),
            selectionDecoration: const BoxDecoration(
              color: AppColors.transparent,
            ),
            headerStyle: const CalendarHeaderStyle(
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                fontFamily: "Poppins",
              ),
            ),
            viewHeaderStyle: const ViewHeaderStyle(
              dateTextStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 10,
                fontFamily: "Poppins",
              ),
              dayTextStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 10,
                fontFamily: "Poppins",
              ),
            ),
            cellBorderColor: AppColors.transparent,
            onTap: (calendarTapDetails) => print(calendarTapDetails.date!.day),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}

class AttendanceDataSource extends CalendarDataSource {
  AttendanceDataSource(List<Map<String, dynamic>> source) {
    appointments = source;
  }
}
