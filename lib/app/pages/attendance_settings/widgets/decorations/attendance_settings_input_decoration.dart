import 'package:flutter/material.dart';

class AttendanceSettingsInputDecoration extends InputDecoration {
  AttendanceSettingsInputDecoration({
    String labelText = "",
    String hintText = "",
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) : super(
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        );
}
