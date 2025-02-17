import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../controllers/timer_controller.dart';

class TimerPainter extends CustomPainter {
  final TimerController controller;
  final double size;

  TimerPainter(this.controller, this.size);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const totalTicks = 40;

    // 눈금과 path 관련 크기 계산 분리
    final tickLength = size.width * 0.15;
    final tickWidth = size.width * 0.02;
    final pathWidth = size.width * 0.3;
    final pathLength = size.width * 0.2;
    
    // 호를 더 넓게 감싸도록 각도 조정
    final startAngle = math.pi + 0.6;
    final endAngle = -0.6;
    
    final tickRadius = radius;
    final pathRadius = radius + 5;
    final pathStartRadius = radius + 5;
    
    final pathStartAngle = startAngle + 0.15;

    // 배경 영역 설정
    final bounds = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.saveLayer(bounds, Paint());

    // 눈금 그리기
    final tickPath = Path();
    for (var i = 0; i <= totalTicks; i++) {
      final angle = startAngle - ((startAngle - endAngle) * i / totalTicks);

      final innerX = center.dx + (tickRadius - tickLength) * math.cos(angle);
      final innerY = center.dy - (tickRadius - tickLength) * math.sin(angle);
      final outerX = center.dx + tickRadius * math.cos(angle);
      final outerY = center.dy - tickRadius * math.sin(angle);

      final tickRect = Path()
        ..moveTo(innerX, innerY)
        ..lineTo(outerX, outerY);

      tickPath.addPath(tickRect, Offset.zero);
    }

    // 배경 눈금 그리기
    canvas.drawPath(
        tickPath,
        Paint()
          ..color = Colors.grey[800]!
          ..strokeWidth = tickWidth
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);

    // 프로그레스 그리기
    if (controller.isStarted.value) {
      final animatedProgress = controller.animatedProgress.value;
      
      // 더 세밀한 진행 상태 계산
      final exactTick = totalTicks * animatedProgress;
      final progressTicks = exactTick.floor();
      final partialProgress = exactTick - progressTicks;
      
      final progressClip = Path();
      
      // 시작점 계산
      final startX = center.dx + pathStartRadius * math.cos(pathStartAngle);
      final startY = center.dy - pathStartRadius * math.sin(pathStartAngle);
      progressClip.moveTo(startX, startY);
      
      // 첫 번째 눈금까지 더 부드럽게 연결
      final firstTickX = center.dx + pathRadius * math.cos(startAngle);
      final firstTickY = center.dy - pathRadius * math.sin(startAngle);
      
      // 컨트롤 포인트 조정으로 더 부드러운 곡선 생성
      final controlX = center.dx + pathRadius * math.cos(pathStartAngle - 0.15);
      final controlY = center.dy - pathRadius * math.sin(pathStartAngle - 0.15);
      
      progressClip.quadraticBezierTo(controlX, controlY, firstTickX, firstTickY);

      // 이전 점 저장을 위한 변수
      var prevX = firstTickX;
      var prevY = firstTickY;

      // 완전한 틱까지 그리기
      for (var i = 1; i <= progressTicks; i++) {
        final t = i / totalTicks;
        final angle = startAngle - ((startAngle - endAngle) * t);
        final x = center.dx + pathRadius * math.cos(angle);
        final y = center.dy - pathRadius * math.sin(angle);
        
        // 더 부드러운 곡선을 위한 제어점 계산
        final prevT = (i - 0.5) / totalTicks;
        final prevAngle = startAngle - ((startAngle - endAngle) * prevT);
        
        final controlX = center.dx + (pathRadius + 3) * math.cos(prevAngle);
        final controlY = center.dy - (pathRadius + 3) * math.sin(prevAngle);
        
        progressClip.quadraticBezierTo(controlX, controlY, x, y);
      }

      // 현재 진행 중인 부분 그리기
      if (partialProgress > 0) {
        final currentT = progressTicks / totalTicks;
        final nextT = (progressTicks + 1) / totalTicks;
        final t = currentT + (nextT - currentT) * partialProgress;
        
        final angle = startAngle - ((startAngle - endAngle) * t);
        final x = center.dx + pathRadius * math.cos(angle);
        final y = center.dy - pathRadius * math.sin(angle);
        
        final prevT = (progressTicks + 0.5) / totalTicks;
        final controlAngle = startAngle - ((startAngle - endAngle) * prevT);
        final controlX = center.dx + (pathRadius + 3) * math.cos(controlAngle);
        final controlY = center.dy - (pathRadius + 3) * math.sin(controlAngle);
        
        progressClip.quadraticBezierTo(controlX, controlY, x, y);
      }

      progressClip.lineTo(center.dx, center.dy);
      progressClip.lineTo(startX, startY);
      progressClip.close();

      canvas.clipPath(progressClip);

      canvas.drawPath(
          tickPath,
          Paint()
            ..color = const Color(0xFF9438F5)
            ..strokeWidth = pathWidth
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke
            ..blendMode = BlendMode.srcIn
      );
    }

    canvas.restore();
  }

  // 더 부드러운 보간 함수
  double _smoothStep(double t) {
    t = (t * t * (3 - 2 * t)).clamp(0.0, 1.0);
    return t;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
