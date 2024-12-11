import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomSpinningAnimation extends StatefulWidget {
  final Color color;

  const CustomSpinningAnimation({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  State<CustomSpinningAnimation> createState() =>
      _CustomSpinningAnimationState();
}

class _CustomSpinningAnimationState extends State<CustomSpinningAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: SpinningPainter(
            color: widget.color,
            progress: _controller.value,
          ),
        );
      },
    );
  }
}

class SpinningPainter extends CustomPainter {
  final Color color;
  final double progress;

  SpinningPainter({
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2 - 10);
    final radius = (size.width / 2) + 3;

    // Transform.rotate를 사용하여 전체 캔버스를 180도 회전
    canvas.translate(size.width, size.height);
    canvas.rotate(math.pi);

    // 시작 각도 계산 (0도에서 180도 사이에서만 회전)
    final startAngle = math.pi * (progress);
    // 이동한 위치에 따라 작아지다가 커짐
    var sweepAngle = math.pi * (progress) / 10;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
