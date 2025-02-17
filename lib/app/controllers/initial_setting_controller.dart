import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holdemtimerapp/app/controllers/global/socket_controller.dart';
import 'package:holdemtimerapp/utils/logger/app_logger.dart';
import 'package:holdemtimerapp/app/models/connection/server_connection_state.dart';

class InitialSettingController extends GetxController {
  final AppLogger logger = const AppLogger('InitialSettingController');

  final TextEditingController ipController = TextEditingController();

  SocketController? socketController;

  RxBool get isConnectionWaiting =>
      socketController?.isConnectionWaiting ?? false.obs;

  @override
  void onInit() {
    super.onInit();
    init();
    ever(socketController?.connectionState ?? ServerConnectionState.initial.obs,
        _handleConnectionStateChange);
  }

  Future<void> init() async {
    logger.info('초기화 시작');
    socketController = Get.find<SocketController>();
  }

  void _handleConnectionStateChange(ServerConnectionState state) {
    switch (state) {
      case ServerConnectionState.initial:
        break;
      case ServerConnectionState.waiting:
        break;
      case ServerConnectionState.connected:
        Get.snackbar(
          '연결 성공',
          '서버와 연결되었습니다.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        break;
      case ServerConnectionState.disconnected:
        break;
      case ServerConnectionState.error:
        connectionFailed('서버 연결 중 오류가 발생했습니다.');
        break;
    }
  }

  bool isValidIpAddress(String ip) {
    final ipRegex = RegExp(
        r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
    return ipRegex.hasMatch(ip);
  }

  Future<void> connectToServer() async {
    if (!isValidIpAddress(ipController.text)) {
      connectionFailed('올바른 IP 주소를 입력해주세요.');
      return;
    }

    if (isCanConnect()) {
      socketController?.connect(ipController.text);
    }
  }

  bool isCanConnect() {
    if (socketController == null) {
      connectionFailed('소켓 컨트롤러가 초기화되지 않았습니다.');
      return false;
    }

    if (ipController.text.isEmpty) {
      connectionFailed('IP 주소를 입력해주세요.');
      return false;
    }

    if (socketController?.connectionState.value ==
        ServerConnectionState.waiting) {
      connectionFailed('이미 연결을 시도중입니다.');
      return false;
    }

    return true;
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
}
