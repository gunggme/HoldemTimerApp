import 'package:holdemtimerapp/app/models/connection/server_connection_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:get/get.dart';
import 'dart:async';

class SocketController extends GetxController {
  SocketController();

  WebSocketChannel? channel;
  final RxString ip = '192.168.1.100'.obs;
  Timer? _reconnectTimer;
  static const int _reconnectDelay = 3000; // 3초

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
  }

  Future<void> connect(String ip) async {
    try {
      this.ip.value = ip;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('ip', ip);

      setConnectionState(ServerConnectionState.waiting);

      channel = WebSocketChannel.connect(
        Uri.parse('ws://$ip:8000/devices/ws'),
      );

      channel?.stream.listen(
        (message) {
          print('Received: $message');
          setConnectionState(ServerConnectionState.connected);
        },
        onError: (error) {
          print('WebSocket Error: $error');
          setConnectionState(ServerConnectionState.error);
        },
        onDone: () {
          print('WebSocket connection closed');
          setConnectionState(ServerConnectionState.disconnected);
        },
      );
    } catch (e) {
      print('Connection Error: $e');
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
