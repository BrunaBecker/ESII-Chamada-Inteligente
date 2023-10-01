import 'package:flutter/material.dart';

import '../../../core/theme/app_assets.dart';

class LoginAppLogo extends StatelessWidget {
  const LoginAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Image.asset(
        ImageAssets.appLogo,
        fit: BoxFit.contain,
      ),
    );
  }
}
