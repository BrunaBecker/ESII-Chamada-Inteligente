import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

abstract class AppDateUtils {
  static final appDateFormat = DateFormat(appDatePattern);
  static final storageDateFormat = DateFormat(storageDatePattern);
  static final appDateTimeFormat = DateFormat(appDateTimePattern);
  static final storageDateTimeFormat = DateFormat(storageDateTimePattern);

  static String convertAppToStorage(String date) {
    return storageDateFormat.format(AppDateUtils.appDateFormat.parse(date));
  }

  static String convertStorageToApp(String date) {
    return appDateFormat.format(AppDateUtils.storageDateFormat.parse(date));
  }

  static String timeOfDayToAppString(TimeOfDay time) {
    return "${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}";
  }

  static String dateTimeToTimeString(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, "0")}:${dateTime.minute.toString().padLeft(2, "0")}";
  }

  /// Parse a Java duration string to a [Duration] object.
  ///
  /// A valid example for [javaDuration] is ``P1Y2M3DT4H5M6.789S``.
  static Duration parseJavaDuration(String javaDuration) {
    try {
      RegExp regex = RegExp(
        r"^P(\d+Y)?(\d+M)?(\d+D)?(T(\d+H)?(\d+M)?(\d+(\.\d+)?S)?)?$",
      );
      Match match = regex.firstMatch(javaDuration)!;
      final yearsString = match.group(1) ?? "0 ";
      final monthsString = match.group(2) ?? "0 ";
      final daysString = match.group(3) ?? "0 ";
      final hoursString = match.group(5) ?? "0 ";
      final minutesString = match.group(6) ?? "0 ";
      final secondsString = match.group(7) ?? "0 ";
      int years = int.parse(
        yearsString.substring(0, yearsString.length - 1),
      );
      int months = int.parse(
        monthsString.substring(0, monthsString.length - 1),
      );
      int days = int.parse(
        daysString.substring(0, daysString.length - 1),
      );
      int hours = int.parse(
        hoursString.substring(0, hoursString.length - 1),
      );
      int minutes = int.parse(
        minutesString.substring(0, minutesString.length - 1),
      );
      double seconds = double.parse(
        secondsString.substring(0, secondsString.length - 1),
      );

      final duration = Duration(
        days: years * 365 + months * 30 + days,
        hours: hours,
        minutes: minutes,
        seconds: seconds.toInt(),
        milliseconds: ((seconds - seconds.toInt()) * 1000).toInt(),
      );
      return duration;
    } catch (_) {
      throw const FormatException("Invalid duration format.");
    }
  }

  static Duration timeStringToDuration(String time) {
    final firstTimePart = time.split(":");
    final secondTimePart = firstTimePart.last.split(".");
    var hours = 0;
    var minutes = 0;
    var seconds = 0;
    var milliseconds = 0;
    if (firstTimePart.length < 2) {
      throw const FormatException("Invalid time format.");
    }
    if (firstTimePart.length >= 2) {
      hours = int.parse(firstTimePart[0]);
      minutes = int.parse(firstTimePart[1]);
    }
    if (firstTimePart.length >= 3) {
      seconds = int.parse(firstTimePart[2]);
    }
    if (secondTimePart.length >= 2) {
      milliseconds = int.parse(secondTimePart[1]);
    }

    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
    );
  }

  static DateTime combineDateTime(DateTime date, String hour) {
    return storageDateTimeFormat
        .parse("${storageDateFormat.format(date)} $hour");
  }

  static String storageToAppHour(String hour) {
    if (hour.length == 8) {
      return hour.substring(0, 5);
    }
    return hour;
  }
}
