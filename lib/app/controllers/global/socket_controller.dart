import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:holdemtimerapp/app/models/connection/server_connection_state.dart';
import 'package:holdemtimerapp/utils/logger/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:async';

class SocketController extends GetxController {
  AppLogger _logger = AppLogger('SocketController');

  WebSocketChannel? channel;
  final RxString ip = '192.168.1.100'.obs;
  Timer? _reconnectTimer;
  static const int _reconnectDelay = 3000; // 3초

  final RxString deviceName = "".obs;
  final RxString deviceUid = "".obs;

  final Rx<ServerConnectionState> connectionState =
      ServerConnectionState.initial.obs;

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
    initDeviceInfo();
  }

  Future<void> initDeviceInfo() async {
    try {
      final deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceName.value = androidInfo.model;
        deviceUid.value = androidInfo.id;
        _logger.info('Android 기기 정보: ${deviceName.value}, ${deviceUid.value}');
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceName.value = iosInfo.name ?? "Unknown iOS Device";
        deviceUid.value = iosInfo.identifierForVendor ?? "Unknown ID";
        _logger.info('iOS 기기 정보: ${deviceName.value}, ${deviceUid.value}');
      }
    } catch (e) {
      _logger.error('기기 정보 가져오기 실패: $e');
      // 기본값 설정
      deviceName.value = "Unknown Device";
      deviceUid.value = DateTime.now().millisecondsSinceEpoch.toString();
    }
  }

  Future<void> connect(String ip) async {
    try {
      this.ip.value = ip;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('ip', ip);

      _logger.info('서버 연결 시도: $ip');

      http.Response response = await http.get(
        Uri.parse('http://$ip:8000/health'),
      );

      _logger.info('서버 상태 확인: ${response.statusCode}');

      if (response.statusCode == 200) {
        setConnectionState(ServerConnectionState.waiting);
      } else {
        setConnectionState(ServerConnectionState.error);
        return;
      }

      channel = WebSocketChannel.connect(
        Uri.parse('ws://$ip:8000/devices/ws'),
      );

      channel?.stream.listen(
        (message) {
          handleMessage(message);
        },
        onError: (error) {
          _logger.error('WebSocket Error: $error');
          setConnectionState(ServerConnectionState.error);
        },
        onDone: () {
          _logger.info('WebSocket connection closed');
          setConnectionState(ServerConnectionState.disconnected);
        },
      );

      // 디바이스 정보 전송
      channel?.sink.add(jsonEncode({
        'response': '200',
        'device_name': deviceName.value,
        'device_uid': deviceUid.value,
      }));
    } catch (e) {
      _logger.error('Connection Error: $e');
      setConnectionState(ServerConnectionState.error);
    }
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(Duration(milliseconds: _reconnectDelay), () {
      if (connectionState.value == ServerConnectionState.error ||
          connectionState.value == ServerConnectionState.disconnected) {
        connect(ip.value);
      }
    });
  }

  Future<void> handleMessage(String message) async {
    _logger.info('서버 메시지 수신: $message');
    Map<String, dynamic> dataJson = jsonDecode(message);
    String data = dataJson['data'];

    if (isConnectionWaiting.value) {
      if (data == "Wait Auth Device") {}
      if (data == "connected") {
        setConnectionState(ServerConnectionState.connected);
      }
    }
  }

  void setConnectionState(ServerConnectionState state) {
    connectionState.value = state;
  }

  @override
  void dispose() {
    _reconnectTimer?.cancel();
    channel?.sink.close();
    super.dispose();
  }
}
