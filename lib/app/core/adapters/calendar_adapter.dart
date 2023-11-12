import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../enums/event_status.dart';
import '../theme/app_colors.dart';
import '../utils/app_date_utils.dart';

class CalendarAdapter extends StatelessWidget {
  const CalendarAdapter({
    super.key,
    this.events = const [],
  });

  final List<Map<String, dynamic>> events;

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      firstDayOfWeek: 1,
      monthViewSettings: const MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
        showAgenda: true,
        monthCellStyle: MonthCellStyle(
          textStyle: defaultTextStyle,
          trailingDatesTextStyle: defaultTextStyle,
          leadingDatesTextStyle: defaultTextStyle,
        ),
      ),
      todayTextStyle: defaultTextStyle,
      selectionDecoration: const BoxDecoration(
        color: AppColors.transparent,
      ),
      headerStyle: const CalendarHeaderStyle(
        textStyle: defaultTitleStyle,
      ),
      viewHeaderStyle: const ViewHeaderStyle(
        dateTextStyle: defaultTextStyle,
        dayTextStyle: defaultTextStyle,
      ),
      cellBorderColor: AppColors.transparent,
      dataSource: AttendanceDataSource(
        events,
      ),
      onTap: (calendarTapDetails) {
        final appointments = calendarTapDetails.appointments ?? [];
        if (appointments.length == 1) {
          final appointment = appointments.first;
          final startTime =
              AppDateUtils.dateTimeToTimeString(appointment["startTime"]);
          final endTime =
              AppDateUtils.dateTimeToTimeString(appointment["endTime"]);
          showDialog(
            context: context,
            builder: (context) => EventInfoDialog(
              title: appointment["class"],
              description: "$startTime - $endTime",
              status: appointment["status"],
              center: true,
            ),
          );
        }
      },
    );
  }

  static const defaultTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 10,
    fontFamily: "Poppins",
  );
  static const defaultTitleStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    fontFamily: "Poppins",
  );
}

class AttendanceDataItem {
  AttendanceDataItem({
    required this.classTitle,
    required this.classTime,
    required this.classStatus,
  });

  final String classTitle;
  final String classTime;
  final int classStatus;
}

class AttendanceDataSource extends CalendarDataSource {
  @override
  Color getColor(int index) {
    return getAppointment(index)["color"] as Color? ?? AppColors.lightGray;
  }

  @override
  DateTime getStartTime(int index) {
    return getAppointment(index)["startTime"] as DateTime;
  }

  @override
  DateTime getEndTime(int index) {
    return getAppointment(index)["endTime"] as DateTime;
  }

  @override
  String getSubject(int index) {
    return getAppointment(index)["class"] as String;
  }

  Map<String, dynamic> getAppointment(int index) {
    return appointments![index];
  }

  AttendanceDataSource(List source) {
    appointments = source;
  }
}

class EventInfoDialog extends StatelessWidget {
  const EventInfoDialog({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    this.center = false,
  }) : color = status == EventStatus.classNormal
            ? AppColors.green1
            : status == EventStatus.classCancelled
                ? AppColors.redDarker
                : AppColors.orange;

  final String title;
  final String description;
  final EventStatus status;
  final Color color;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(
        status == EventStatus.classNormal
            ? Icons.check_outlined
            : status == EventStatus.classCancelled
                ? Icons.close_outlined
                : Icons.schedule_outlined,
        color: color,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color,
        ),
      ),
      content: Text(
        description,
        textAlign: center ? TextAlign.center : TextAlign.start,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Ok"),
        ),
      ],
    );
  }
}
