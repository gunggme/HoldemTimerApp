import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';
import '../widgets/timer_display.dart';
import '../widgets/timer_controls.dart';
import '../widgets/blinds_text.dart';
import '../widgets/ante_text.dart';
import '../widgets/status_info.dart';

class TimerView extends GetView<TimerController> {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.black,
        title: const Text(
          'Daily game',
          style: TextStyle(color: Colors.grey),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
            controller.resetTimer();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
      body: Row(
        children: [
          // 왼쪽 영역 (Blinds)
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlindsText(),
              ],
            ),
          ),
          // 중앙 영역 (Timer)
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TimerDisplay(
                  controller: controller,
                  size: 200,
                ),
                TimerControls(
                  controller: controller,
                  showBackButton: false,
                ),
              ],
            ),
          ),
          // 오른쪽 영역 (Ante + Status)
          Expanded(
            flex: 1,
            child: AnteText(),
          ),
          Expanded(
            flex: 1,
              child: StatusInfo())
        ],
      ),
    );
  }
}
