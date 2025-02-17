import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';
import '../widgets/setting_controls.dart';

class InGameSettingView extends GetView<TimerController> {
  const InGameSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Daily game',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[800]!,
            width: 1,
          ),
        ),
        child: const SettingControls(),
      ),
    );
  }
} 