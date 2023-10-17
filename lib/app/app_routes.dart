import 'package:get/get.dart';

import 'pages/attendance_info/attendance_info_bindings.dart';
import 'pages/attendance_info/attendance_info_widget.dart';
import 'pages/attendance_settings/attendance_settings_bindings.dart';
import 'pages/attendance_settings/attendance_settings_widget.dart';
import 'pages/calendar/calendar_bindings.dart';
import 'pages/calendar/calendar_widget.dart';
import 'pages/class_info/class_info_bindings.dart';
import 'pages/class_info/class_info_widget.dart';
import 'pages/classes/classes_bindings.dart';
import 'pages/classes/classes_widget.dart';
import 'pages/home/home_bindings.dart';
import 'pages/home/home_widget.dart';
import 'pages/login/login_bindings.dart';
import 'pages/login/login_widget.dart';
import 'pages/notifications/notifications_bindings.dart';
import 'pages/notifications/notifications_widget.dart';
import 'pages/settings/settings_bindings.dart';
import 'pages/settings/settings_widget.dart';

abstract class AppRoutes {
  static const login = "/login";

  static const home = "/home";

  static const notifications = "/notifications";

  static const classes = "/classes";

  static const calendar = "/calendar";

  static const settings = "/settings";

  static const attendanceSettings = "/attendance-settings";

  static const classInfo = "/class-info";

  static const attendanceInfo = "/attendance-info";

  static final routes = <GetPage>[
    GetPage(
      name: login,
      page: () => const LoginWidget(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: home,
      page: () => const HomeWidget(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: notifications,
      page: () => const NotificationsWidget(),
      binding: NotificationsBindings(),
    ),
    GetPage(
      name: classes,
      page: () => const ClassesWidget(),
      binding: ClassesBindings(),
    ),
    GetPage(
      name: calendar,
      page: () => const CalendarWidget(),
      binding: CalendarBindings(),
    ),
    GetPage(
      name: settings,
      page: () => const SettingsWidget(),
      binding: SettingsBindings(),
    ),
    GetPage(
      name: attendanceSettings,
      page: () => const AttendanceSettingsWidget(),
      binding: AttendanceSettingsBindings(),
    ),
    GetPage(
      name: classInfo,
      page: () => const ClassInfoWidget(),
      binding: ClassInfoBindings(),
    ),
    GetPage(
      name: attendanceInfo,
      page: () => const AttendanceInfoWidget(),
      binding: AttendanceInfoBindings(),
    ),
  ];
}
