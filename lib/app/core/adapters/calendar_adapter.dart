import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../domain/entities/event_entity.dart';
import '../enums/event_status.dart';
import '../theme/app_colors.dart';
import '../utils/app_date_utils.dart';
import '../widgets/event_info_dialog.dart';

class CalendarAdapter extends StatelessWidget {
  const CalendarAdapter({
    super.key,
    this.events = const [],
    this.onSelectionChanged,
    this.onViewChanged,
  });

  final List<EventEntity> events;
  final Function(CalendarSelectionDetails)? onSelectionChanged;
  final Function(ViewChangedDetails)? onViewChanged;

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      onSelectionChanged: onSelectionChanged,
      onViewChanged: onViewChanged,
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
          final appointment = appointments.first as EventEntity;
          final startTime = appointment.classroom.startHour;
          final endTime = appointment.classroom.endHour;
          showDialog(
            context: context,
            builder: (context) => EventInfoDialog(
              title: appointment.classroom.courseName,
              description: "$startTime - $endTime",
              status: appointment.status,
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
    return getAppointment(index).status == EventStatus.classNormal
        ? AppColors.green1
        : getAppointment(index).status == EventStatus.classCancelled
            ? AppColors.redDarker
            : AppColors.orange;
  }

  @override
  DateTime getStartTime(int index) {
    final appointment = getAppointment(index);
    final start = AppDateUtils.combineDateTime(
      appointment.date,
      appointment.classroom.startHour,
    );
    return start;
  }

  @override
  DateTime getEndTime(int index) {
    final appointment = getAppointment(index);
    final end = AppDateUtils.combineDateTime(
      appointment.date,
      appointment.classroom.endHour,
    );
    return end;
  }

  @override
  String getSubject(int index) {
    return getAppointment(index).name;
  }

  EventEntity getAppointment(int index) {
    return appointments![index];
  }

  AttendanceDataSource(List source) {
    appointments = source;
  }
}
