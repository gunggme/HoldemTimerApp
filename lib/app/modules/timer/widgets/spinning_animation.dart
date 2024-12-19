import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomSpinningAnimation extends StatefulWidget {
  final Color color;
  final double size;

  const CustomSpinningAnimation({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  State<CustomSpinningAnimation> createState() => _CustomSpinningAnimationState();
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
            size: widget.size,
          ),
        );
      },
    );
  }
}

class SpinningPainter extends CustomPainter {
  final Color color;
  final double progress;
  final double size;

  SpinningPainter({
    required this.color,
    required this.progress,
    required this.size,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width * 0.01; // 3.0 / 300 = 0.01
    final yOffset = size.width * 0.033; // 10.0 / 300 = 0.033
    final radiusOffset = size.width * 0.01; // 3.0 / 300 = 0.01

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2 - yOffset);
    final radius = (size.width / 2) + radiusOffset;

    canvas.translate(size.width, size.height);
    canvas.rotate(math.pi);

    final startAngle = math.pi * (progress);
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
