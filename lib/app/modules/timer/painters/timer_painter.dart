import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../controllers/timer_controller.dart';

class TimerPainter extends CustomPainter {
  final TimerController controller;

  TimerPainter(this.controller);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 - 10);
    var radius = size.width / 2;

    // 1. 배경 눈금 그리기
    final tickPath = Path();
    const tickLength = 20.0;
    const totalTicks = 30;

    List<Offset> tickPoints = [];
    for (var i = 0; i < totalTicks; i++) {
      final angle = (math.pi * i - 10) / (totalTicks / 1.34);
      final x1 = center.dx + (radius - tickLength) * math.cos(angle);
      final y1 = center.dy + (radius - tickLength) * math.sin(angle);
      final x2 = center.dx + radius * math.cos(angle);
      final y2 = center.dy + radius * math.sin(angle);

      tickPath.moveTo(x1, y1);
      tickPath.lineTo(x2, y2);
      
      // 눈금의 안쪽 점 저장
      tickPoints.add(Offset(x1, y1));
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
      
      // 진행된 만큼의 눈금 포인트 계산
      final progressPoints = (progress * tickPoints.length).floor();
      
      if (progressPoints > 0) {
        // 첫 번째 점으로 이동
        progressPath.moveTo(tickPoints[0].dx, tickPoints[0].dy);
        
        // 각 눈금 포인트를 직선으로 연결
        for (var i = 1; i < progressPoints; i++) {
          progressPath.lineTo(tickPoints[i].dx, tickPoints[i].dy);
        }
        
        // 마지막 부분 처리
        if (progressPoints < tickPoints.length) {
          final nextPoint = tickPoints[progressPoints];
          final lastPoint = tickPoints[progressPoints - 1];
          final remainingProgress = (progress * tickPoints.length) - progressPoints;
          
          final lastX = lastPoint.dx + (nextPoint.dx - lastPoint.dx) * remainingProgress;
          final lastY = lastPoint.dy + (nextPoint.dy - lastPoint.dy) * remainingProgress;
          
          progressPath.lineTo(lastX, lastY);
        }
      }

      // 프로그레스 라인 그리기
      canvas.drawPath(
        progressPath,
        Paint()
          ..color = const Color(0xFF9438F5)
          ..strokeWidth = 40
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
