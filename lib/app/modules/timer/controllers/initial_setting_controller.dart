import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_ip_address/get_ip_address.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';
import 'dart:convert';

class InitialSettingController extends GetxController {
  final TextEditingController ipController = TextEditingController();
  final TextEditingController authCodeController = TextEditingController();

  final RxBool isConnected = false.obs;
  final RxString connectionStatus = '연결 대기중'.obs;
  final RxBool isIpVerified = false.obs; // IP 검증 상태
  final RxBool showAuthCodeField = false.obs; // 인증 코드 입력 필드 표시 여부

  @override
  void onInit() {
    super.onInit();
    initPrefs();
  }

  Future<void> initPrefs() async {
    loadSavedSettings();
  }

  void loadSavedSettings() {}
}
