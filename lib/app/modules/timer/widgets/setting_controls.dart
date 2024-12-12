import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';

class SettingControls extends GetView<TimerController> {
  const SettingControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() => _buildControlBox('Players', '${controller.currentPlayers}/${controller.maxPlayers}')),
            Obx(() => _buildControlBox('Entries', controller.entries.toString())),
            Obx(() => _buildControlBox('Rebuys', controller.rebuys.toString())),
            Obx(() => _buildControlBox('Add-ons', controller.addOns.toString())),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildControlButtons(
              'Players',
              onIncrement: controller.incrementPlayers,
              onDecrement: controller.decrementPlayers,
            ),
            const SizedBox(width: 20),
            _buildControlButtons(
              'Entries',
              onIncrement: controller.incrementEntries,
              onDecrement: controller.decrementEntries,
            ),
            const SizedBox(width: 80),
            _buildControlButtons(
              'Rebuys',
              onIncrement: controller.incrementRebuys,
              onDecrement: controller.decrementRebuys,
            ),
            const SizedBox(width: 20),
            _buildControlButtons(
              'Add-ons',
              onIncrement: controller.incrementAddOns,
              onDecrement: controller.decrementAddOns,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF9438F5),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            'PAUSE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControlBox(String label, String value) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButtons(
    String label, {
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          _buildButton('+', onPressed: onIncrement),
          Container(
            width: 1,
            height: 30,
            color: Colors.black,
          ),
          _buildButton('-', onPressed: onDecrement),
        ],
      ),
    );
  }

  Widget _buildButton(String symbol, {required VoidCallback onPressed}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Text(
          symbol,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
} 