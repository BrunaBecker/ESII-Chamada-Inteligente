import 'dart:developer';

import '../enums/ansi_color.dart';

void appLog(
  String message, {
  AnsiColor? color,
  DateTime? time,
  int level = 0,
  String name = "",
  Object? error,
  StackTrace? stackTrace,
}) {
  if (color != null) {
    message = "\x1B[${color.code}m$message\x1B[0m";
  }

  log(
    message,
    time: time,
    level: level,
    name: name,
    error: error,
    stackTrace: stackTrace,
  );
}
