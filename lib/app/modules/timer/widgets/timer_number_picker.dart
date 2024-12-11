import 'package:flutter/material.dart';

class TimerNumberPicker extends StatelessWidget {
  final int value;
  final int maxValue;
  final Function(int) onChanged;

  const TimerNumberPicker({
    Key? key,
    required this.value,
    required this.maxValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Column(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_drop_up, color: Colors.white, size: 48),
              onPressed: () {
                if (value < maxValue) {
                  onChanged(value + 1);
                }
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                value.toString().padLeft(2, '0'),
                style: const TextStyle(
                  color: Color(0xFF98FB98),
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white, size: 48),
              onPressed: () {
                if (value > 0) {
                  onChanged(value - 1);
                }
              },
            ),
          ],
        ),
      ],
    );
  }
} 