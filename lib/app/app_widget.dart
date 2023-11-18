import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_bindings.dart';
import 'app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "MAC-FI",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'Minecraft'),
      getPages: AppRoutes.routes,
      initialRoute: AppRoutes.login,
      initialBinding: AppBindings(),
      defaultTransition: Transition.noTransition,
    );
  }
}
