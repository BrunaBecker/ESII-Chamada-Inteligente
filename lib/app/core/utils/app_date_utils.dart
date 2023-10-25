import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

abstract class AppDateUtils {
  static final appDateFormat = DateFormat(appDatePattern);
  static final storageDateFormat = DateFormat(storageDatePattern);

  static String convertAppToStorage(String date) {
    return storageDateFormat.format(AppDateUtils.appDateFormat.parse(date));
  }

  static String convertStorageToApp(String date) {
    return appDateFormat.format(AppDateUtils.storageDateFormat.parse(date));
  }

  static String timeOfDayToAppString(TimeOfDay time) {
    return "${time.hour.toString()}:${time.minute.toString()}";
  }
}
