import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../controllers/timer_controller.dart';

class TimerPainter extends CustomPainter {
  final TimerController controller;

  TimerPainter(this.controller);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 - 10);
    final radius = size.width / 2;

    // 1. 배경 눈금 그리기
    final tickPath = Path();
    const tickLength = 20.0;
    const totalTicks = 50;

    for (var i = 0; i < totalTicks; i++) {
      final angle = (math.pi * i - 20) / (totalTicks / 1.36);

      final x1 = center.dx + (radius - tickLength) * math.cos(angle);
      final y1 = center.dy + (radius - tickLength) * math.sin(angle);
      final x2 = center.dx + radius * math.cos(angle);
      final y2 = center.dy + radius * math.sin(angle);

      tickPath.moveTo(x1, y1);
      tickPath.lineTo(x2, y2);
    }

    // 배경 눈금 그리기
    canvas.drawPath(
      tickPath,
      Paint()
        ..color = Colors.grey[800]!
        ..strokeWidth = 4
        ..style = PaintingStyle.stroke
    );

    // 2. 프로그레스 라인 그리기
    if (controller.isStarted.value) {
      final progress = controller.getProgress();
      
      // 마스킹을 위한 레이어 생성
      final bounds = Rect.fromLTWH(0, 0, size.width, size.height);
      canvas.saveLayer(bounds, Paint());

      // 마스크로 사용할 눈금 그리기
      canvas.drawPath(
        tickPath,
        Paint()
          ..color = Colors.grey[800]!
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke
      );

      final progressPath = Path();
      
      // 시작점을 살짝 아래에서 시작
      final startAngle = -0.65; // 시작 각도를 약간 아래로 조정
      final endAngle = math.pi + 0.45; // 끝 각도도 약간 연장
      
      // 진행된 만큼의 점들을 계산
      final totalAngle = endAngle - startAngle;
      final currentAngle = startAngle + (totalAngle * progress);
      
      // 첫 번째 점 위치 계산
      final firstX = center.dx + (radius - tickLength/2) * math.cos(startAngle);
      final firstY = center.dy + (radius - tickLength/2) * math.sin(startAngle);
      progressPath.moveTo(firstX, firstY);

      // 각도에 따라 직선으로 연결
      const segments = 30; // 선분의 수
      for (var i = 1; i <= segments; i++) {
        final t = i / segments;
        final angle = startAngle + (currentAngle - startAngle) * t;
        final x = center.dx + (radius - tickLength/2) * math.cos(angle);
        final y = center.dy + (radius - tickLength/2) * math.sin(angle);
        progressPath.lineTo(x, y);
      }

      // 프로그레스 라인 그리기
      canvas.drawPath(
        progressPath,
        Paint()
          ..color = const Color(0xFF1FDC1F)
          ..strokeWidth = 20
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.square
          ..blendMode = BlendMode.srcIn
      );
      
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
