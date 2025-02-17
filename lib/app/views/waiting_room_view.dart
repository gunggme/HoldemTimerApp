import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/initial_setting_controller.dart';

class WaitingRoomView extends GetView<InitialSettingController> {
  const WaitingRoomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Daily game',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '대기실',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[800]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '연결 정보',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'IP: ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          controller.ipController.text,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          '상태: ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Obx(() => Text(
                              "연결 대기 중",
                              style: const TextStyle(color: Colors.green),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
