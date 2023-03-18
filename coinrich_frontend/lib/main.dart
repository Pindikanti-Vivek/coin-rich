import 'package:coinrich_frontend/presentation/base/app_bindings.dart';
import 'package:coinrich_frontend/presentation/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/config/app_theme.dart';
import 'core/config/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Coin Rich",
      theme: themeData(),
      getPages: routes,
      initialRoute: "/login",
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: BaseScreen(child: child!),
      ),
    );
  }
}