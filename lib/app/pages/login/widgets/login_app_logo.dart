import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class LoginAppLogo extends StatelessWidget {
  const LoginAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 160,
      color: AppColors.lightGray,
    );
  }
}
