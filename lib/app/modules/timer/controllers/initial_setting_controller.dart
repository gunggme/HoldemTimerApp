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
  final RxBool isIpVerified = false.obs;  // IP 검증 상태
  final RxBool showAuthCodeField = false.obs;  // 인증 코드 입력 필드 표시 여부

  @override
  void onInit() {
    super.onInit();
    initPrefs();
  }

  Future<void> initPrefs() async {
    loadSavedSettings();
  }

  void loadSavedSettings() {
  }

  // IP 연결 요청
  Future<void> verifyIpAddress() async {
    if (ipController.text.isEmpty) {
      showError('IP 주소를 입력해주세요.');
      return;
    }

    connectionStatus.value = 'IP 확인 중...';

    try{
      // 아이피 가져오기
      var ipAddress = IpAddress(type: RequestType.json);
      dynamic data = await ipAddress.getIpAddress();
      String ipString = data.toString();
      Map postData = { "ip" : data["ip"]};
      var body = json.encode(postData);
      print(postData);

      // url조정
      var url = Uri.parse("http://${ipController.text}/register_pc");
      final response = await http.post(
        url,
        headers: {"Content-Type" : "application/json"},
        body: body
      );
      print(response);
      if(response.statusCode == 200){
        connectionStatus.value = "연결 성공!";
        showAuthCodeField.value = true;
      }
      else{
        throw(Exception);
      }
    }
    on IpAddressException catch(e){
      print("잘못된 문제");
      connectionStatus.value = "인터넷 연결 실패";
    }
    catch (e){
      print(e);
      showAuthCodeField.value = false;
      connectionStatus.value = "잘못된 연결";
    }
  }

  // 인증 코드 확인
  Future<void> verifyAuthCode() async {
    final wsUrl = Uri.parse("ws://${ipController.text}/ws/client");
    print(wsUrl);
    final channel = WebSocketChannel.connect(wsUrl);

    await channel.ready;

    channel.sink.add(authCodeController.text);

    channel.stream.listen(
      (message) {
         HandlingSocketMessage(message);
      },
      onError: (error) {
        connectionStatus.value = '서버 연결 오류: $error';
        isConnected.value = false;
        //_startReconnecting();
      },
      onDone: () {
        connectionStatus.value = '서버와 연결이 종료되었습니다';
        isConnected.value = false;
        Get.offNamed("/initial-setting");
        //_startReconnecting();
      },);
  }

  void showGeneratedCode(String code) {
    Get.dialog(
      AlertDialog(
        title: const Text('인증 코드'),
        content: Text('생성된 인증 코드: $code'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void showError(String message) {
    connectionStatus.value = '오류';
    Get.snackbar(
      '오류',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> saveSettings() async {

  }


  void HandlingSocketMessage(String message){
    try{
      switch(message){
        case String msg when msg.contains("Connected Success"):
          print("접속 성공");
          connectionStatus.value = "연결됨";
          Get.offNamed('/waiting-room');  // 대기실로 이동
          break;
      }
    }
    catch(e){
      print(e);
    }
  }

  @override
  void onClose() {
    ipController.dispose();
    authCodeController.dispose();
    super.onClose();
  }
} 