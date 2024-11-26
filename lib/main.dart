import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/core/app_theme.dart';
import 'package:myapp/src/routes/app_pages.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.HOME, // Gunakan Routes.HOME, bukan _Paths
      getPages: AppPages.routes,
      theme: AppTheme.lightAppTheme,
    );
  }
}
