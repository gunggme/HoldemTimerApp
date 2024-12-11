import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';

class TimerControls extends StatelessWidget {
  final TimerController controller;
  final double iconSize;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const TimerControls({
    Key? key,
    required this.controller,
    this.iconSize = 32,
    this.showBackButton = false,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showBackButton) ...[
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: iconSize,
            ),
            onPressed: onBackPressed ?? () {
              controller.resetTimer();
              Get.back();
            },
          ),
          const SizedBox(width: 20),
        ],
        IconButton(
          icon: Obx(() => Icon(
            controller.isRunning.value ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
            size: iconSize,
          )),
          onPressed: () {
            if (controller.isRunning.value) {
              controller.stopTimer();
            } else {
              controller.startTimer();
            }
          },
        ),
        IconButton(
          icon: Icon(
            Icons.refresh,
            color: Colors.white,
            size: iconSize,
          ),
          onPressed: controller.resetTimer,
        ),
      ],
    );
  }
} 