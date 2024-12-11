import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holdemtimerapp/app/modules/timer/controllers/timer_controller.dart';
import 'app/routes/app_pages.dart';

void main() {
  Get.put(TimerController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Timer Bar App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
