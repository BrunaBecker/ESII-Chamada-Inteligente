import 'package:flutter/material.dart';

import 'widgets/login_app_logo.dart';
import 'widgets/login_button.dart';
import 'widgets/login_form.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(30.0),
            child: const SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginAppLogo(),
                  Padding(padding: EdgeInsets.all(8.0)),
                  LoginForm(),
                  Padding(padding: EdgeInsets.all(8.0)),
                  LoginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
