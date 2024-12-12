import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';

class StatusInfo extends GetView<TimerController> {
  const StatusInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Status',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Obx(() => _buildStatusRow('Players', '${controller.currentPlayers}/${controller.maxPlayers}')),
          Obx(() => _buildStatusRow('Entries', controller.entries.toString())),
          Obx(() => _buildStatusRow('Rebuys', controller.rebuys.toString())),
          Obx(() => _buildStatusRow('Add-ons', controller.addOns.toString())),
          const SizedBox(height: 5),
          const Text(
            'Statistics',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Obx(() => _buildStatusRow('Total chip', controller.totalChips.value.toString())),
          Obx(() => _buildStatusRow('Total prize', controller.totalPrize.value.toString())),
          const SizedBox(height: 5),
          const Text(
            'Prize',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Obx(() => _buildPrizeRow('1st', (controller.totalPrize.value * 0.98).round().toString())),
          Obx(() => _buildPrizeRow('2nd', (controller.totalPrize.value * 0.015).round().toString())),
          Obx(() => _buildPrizeRow('3rd', (controller.totalPrize.value * 0.005).round().toString())),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrizeRow(String place, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            place,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '$amount P',
            style: const TextStyle(
              color: Color(0xFFFFD700),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
