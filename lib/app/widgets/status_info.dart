import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';

class StatusInfo extends GetView<TimerController> {
  final double size;

  const StatusInfo({
    Key? key,
    this.size = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 크기에 비례하는 값들 계산
    final titleTextSize = size * 0.043; // 13/300 = 0.043
    final labelTextSize = size * 0.037; // 11/300 = 0.037
    final valueTextSize = size * 0.04; // 12/300 = 0.04
    final dividerHeight = size * 0.007; // 2/300 = 0.007
    final thinDividerHeight = size * 0.003; // 1/300 = 0.003
    final padding = size * 0.067; // 20/300 = 0.067
    final paddingSmall = size * 0.05; // 15/300 = 0.05
    final spacingSmall = size * 0.017; // 5/300 = 0.017
    final spacingTiny = size * 0.003; // 1/300 = 0.003

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: paddingSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDivider(dividerHeight),
          Text(
            'Status',
            style: TextStyle(
              color: Colors.grey,
              fontSize: titleTextSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          _buildTitleDivider(thinDividerHeight),
          SizedBox(height: spacingSmall),
          Obx(() => _buildStatusRow('Players', '${controller.currentPlayers}/${controller.maxPlayers}', labelTextSize, valueTextSize)),
          Obx(() => _buildStatusRow('Entries', controller.entries.toString(), labelTextSize, valueTextSize)),
          Obx(() => _buildStatusRow('Rebuys', controller.rebuys.toString(), labelTextSize, valueTextSize)),
          Obx(() => _buildStatusRow('Add-ons', controller.addOns.toString(), labelTextSize, valueTextSize)),
          SizedBox(height: spacingSmall),
          _buildDivider(dividerHeight),
          SizedBox(height: spacingTiny),
          Text(
            'Statistics',
            style: TextStyle(
              color: Colors.grey,
              fontSize: titleTextSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          _buildTitleDivider(thinDividerHeight),
          SizedBox(height: spacingSmall),
          Obx(() => _buildStatusRow('Total chip', controller.totalChips.value.toString(), labelTextSize, valueTextSize)),
          Obx(() => _buildStatusRow('Total prize', controller.totalPrize.value.toString(), labelTextSize, valueTextSize)),
          SizedBox(height: spacingSmall),
          _buildDivider(dividerHeight),
          SizedBox(height: spacingTiny),
          Text(
            'Join QRCode',
            style: TextStyle(
              color: Colors.grey,
              fontSize: titleTextSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          _buildTitleDivider(dividerHeight),
          Image.asset('assets/images/test_qr_code.png', height: size / 3.2, width: size / 3.2,),
        ],
      ),
    );
  }

  Widget _buildDivider(double height) {
    return Container(
      height: height,
      color: const Color(0xFF4E4E4E),
    );
  }

  Widget _buildTitleDivider(double height) {
    return Container(
      height: height,
      color: const Color(0xFF4E4E4E),
    );
  }

  Widget _buildStatusRow(String label, String value, double labelSize, double valueSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontSize: labelSize,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: valueSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
