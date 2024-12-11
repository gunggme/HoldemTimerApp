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
                    color: const Color(0xFF98FB98),
                  )
                : const SizedBox()),
          ),
        Obx(() => Text(
          '${controller.minutes.toString().padLeft(2, '0')}:${controller.seconds.toString().padLeft(2, '0')}',
          style: const TextStyle(
            fontSize: 48,
            color: Color(0xFF98FB98),
            fontWeight: FontWeight.bold,
          ),
        )),
      ],
    );
  }
} 