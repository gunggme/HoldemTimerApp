import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holdemtimerapp/app/models/connection/server_connection_state.dart';
import 'dart:async';

class InitialSettingController extends GetxController {
  final TextEditingController ipController = TextEditingController();

  final Rx<ServerConnectionState> connectionState =
      ServerConnectionState.initial.obs;
  final RxString connectionStatus = '연결 대기중'.obs;
  final RxBool isIpVerified = false.obs; // IP 검증 상태
  final RxBool showAuthCodeField = false.obs; // 인증 코드 입력 필드 표시 여부

  RxBool get isConnectionInitial =>
      (connectionState.value == ServerConnectionState.initial).obs;
  RxBool get isConnectionWaiting =>
      (connectionState.value == ServerConnectionState.waiting).obs;
  RxBool get isConnectionConnected =>
      (connectionState.value == ServerConnectionState.connected).obs;
  RxBool get isConnectionDisconnected =>
      (connectionState.value == ServerConnectionState.disconnected).obs;
  RxBool get isConnectionError =>
      (connectionState.value == ServerConnectionState.error).obs;

  @override
  void onInit() {
    super.onInit();
    initPrefs();
  }

  Future<void> initPrefs() async {}

  Future<void> connectToServer() async {
    connectionState.value = ServerConnectionState.waiting;
    Future.delayed(const Duration(seconds: 3), () {
      connectionState.value = ServerConnectionState.connected;
      Get.snackbar(
        '연결 성공',
        '서버와 연결되었습니다.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    });
  }

  bool isCanConnect() {
    if (connectionState.value == ServerConnectionState.initial &&
        ipController.text.isNotEmpty) {
      return true;
    }
    if (ipController.text.isEmpty) {
      connectionFailed('IP 주소를 입력해주세요.');
    }
    return false;
  }

  void connectionFailed(String explain) {
    Get.snackbar(
      '연결 실패',
      explain,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  void setConnectionState(ServerConnectionState state) {
    connectionState.value = state;
  }
}
