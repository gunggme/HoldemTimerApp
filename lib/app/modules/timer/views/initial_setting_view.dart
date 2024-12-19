import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/initial_setting_controller.dart';

class InitialSettingView extends GetView<InitialSettingController> {
  const InitialSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '서버 설정',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // IP 주소 입력 필드
              TextField(
                controller: controller.ipController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: '서버 IP 주소',
                  labelStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF9438F5)),
                  ),
                  prefixIcon: const Icon(Icons.computer, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
              // IP 확인 버튼
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.verifyIpAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9438F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('IP 확인'),
                ),
              ),
              const SizedBox(height: 10),
              // 인증 코드 입력 필드 (IP 확인 후 표시)
              Obx(() => Visibility(
                visible: controller.showAuthCodeField.value,
                child: Column(
                  children: [
                    TextField(
                      controller: controller.authCodeController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: '인증 코드',
                        labelStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF9438F5)),
                        ),
                        prefixIcon: const Icon(Icons.key, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // 인증 코드 확인 버튼
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: controller.verifyAuthCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF9438F5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('인증하기'),
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 10),
              // 연결 상태 표시
              Obx(() => Text(
                '연결 상태: ${controller.connectionStatus.value}',
                style: TextStyle(
                  color: controller.isConnected.value ? Colors.green : Colors.white,
                  fontSize: 16,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
} 