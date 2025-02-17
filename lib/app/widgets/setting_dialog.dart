import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'setting_controls.dart';

class SettingDialog extends GetView {
  const SettingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.1,
          vertical: Get.height * 0.1,
        ),
        child: Container(
          width: Get.width * 0.8,
          height: Get.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey[800]!,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[800]!,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 40),
                    const Text(
                      'Daily game',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: SettingControls(),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 