import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';
import '../painters/timer_painter.dart';
import 'spinning_animation.dart';

class TimerDisplay extends StatelessWidget {
  final TimerController controller;
  final double size;
  final bool showSpinner;

  const TimerDisplay({
    Key? key,
    required this.controller,
    this.size = 300,
    this.showSpinner = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Transform.rotate(
            angle: 3.14159,
            child: CustomPaint(
              painter: TimerPainter(controller),
            ),
          ),
        ),
        if (showSpinner)
          SizedBox(
            width: size,
            height: size,
            child: Obx(() => controller.isRunning.value
                ? CustomSpinningAnimation(
                    color: const Color(0xFF9438F5),
                  )
                : const SizedBox()),
          ),
        Column(
          children: [
            // TODO 레벨 및 쉬는 시간 지정 해야함
            Obx(() => Text("Level ${controller.testLevelValue}",
              style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),)),
            Obx(() => Text(
              '00:${controller.minutes.toString().padLeft(2, '0')}:${controller.seconds.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 30,
                color: Color(0xFF9438F5),
                fontWeight: FontWeight.bold,
              ),
            )),
          ],
        )
      ],
    );
  }
} 