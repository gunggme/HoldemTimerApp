import 'package:flutter/material.dart';

class BlindsText extends StatelessWidget {
  final double size;

  const BlindsText({
    Key? key,
    this.size = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 크기에 비례하는 값들 계산
    final containerWidth = size * 0.4; // 120/300 = 0.4
    final containerHeight = size * 0.67; // 200/300 = 0.67
    final labelTextSize = size * 0.047; // 14/300 = 0.047
    final valueTextSize = size * 0.08; // 24/300 = 0.08
    final nextTextSize = size * 0.067; // 20/300 = 0.067
    final spacingSmall = size * 0.013; // 4/300 = 0.013
    final spacingMedium = size * 0.027; // 8/300 = 0.027

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Small Blind',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: labelTextSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: spacingSmall),
              Text(
                '-',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: valueTextSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spacingMedium),
              Text(
                'Big Blind',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: labelTextSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: spacingSmall),
              Text(
                '-',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: valueTextSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spacingSmall),
              Text(
                "Ante",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: labelTextSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '-',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: valueTextSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: spacingSmall),
        Text(
          'Next',
          style: TextStyle(
            color: Colors.grey,
            fontSize: labelTextSize,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          '-/-',
          style: TextStyle(
            color: Colors.grey,
            fontSize: nextTextSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}