import 'package:flutter/material.dart';

class LoginInputDecoration extends InputDecoration {
  LoginInputDecoration({
    String labelText = "",
    String hintText = "",
    Widget suffixIcon = const SizedBox(),
  }) : super(
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          contentPadding: const EdgeInsets.all(16.0),
          labelText: labelText,
          hintText: hintText,
          suffixIcon: suffixIcon,
        );
}
