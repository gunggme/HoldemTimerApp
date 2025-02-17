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
    final levelTextSize = size * 0.067;
    final timerTextSize = size * 0.167;

    return Stack(
      alignment: Alignment.center,
      children: [
        // 타이머 원형 프로그레스
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: TimerPainter(controller, size),
          ),
        ),
        // 중앙 텍스트
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Text(
              '${controller.minutes.toString().padLeft(2, '0')}:${controller.seconds.toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: timerTextSize,
                color: const Color(0xFF9438F5),
                fontWeight: FontWeight.bold,
              ),
            )),
            const SizedBox(height: 8),
            Obx(() => Text(
              "Level ${controller.testLevelValue}",
              style: TextStyle(
                fontSize: levelTextSize,
                color: Colors.grey,
              ),
            )),
          ],
        ),
      ],
    );
  }
} 