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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDivider(),
          const Text(
            'Status',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          _buildTitleDivider(),
          const SizedBox(height: 5),
          Obx(() => _buildStatusRow('Players', '${controller.currentPlayers}/${controller.maxPlayers}')),
          Obx(() => _buildStatusRow('Entries', controller.entries.toString())),
          Obx(() => _buildStatusRow('Rebuys', controller.rebuys.toString())),
          Obx(() => _buildStatusRow('Add-ons', controller.addOns.toString())),
          const SizedBox(height: 5),
          _buildDivider(),
          const SizedBox(height: 1),
          const Text(
            'Statistics',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          _buildTitleDivider(),
          const SizedBox(height: 5),
          Obx(() => _buildStatusRow('Total chip', controller.totalChips.value.toString())),
          Obx(() => _buildStatusRow('Total prize', controller.totalPrize.value.toString())),
          const SizedBox(height: 5),
          _buildDivider(),
          const SizedBox(height: 1),
          const Text(
            'Join QRCode',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          _buildTitleDivider(),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 2,
      color: const Color(0xFF4E4E4E),
    );
  }

  Widget _buildTitleDivider() {
    return Container(
      height: 1,
      color: const Color(0xFF4E4E4E),
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
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
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
