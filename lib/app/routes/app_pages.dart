import 'package:get/get.dart';
import '../modules/timer/views/timer_view.dart';
import '../modules/timer/views/initial_setting_view.dart';
import '../modules/timer/views/ingame_setting_view.dart';
import '../modules/timer/views/waiting_room_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INITIAL_SETTING;

  static final routes = [
    GetPage(
      name: Routes.INITIAL_SETTING,
      page: () => const InitialSettingView(),
    ),
    GetPage(
      name: Routes.WAITING_ROOM,
      page: () => const WaitingRoomView(),
    ),
    GetPage(
      name: Routes.TIMER,
      page: () => const TimerView(),
    ),
    GetPage(
      name: Routes.INGAME_SETTING,
      page: () => const InGameSettingView(),
    ),
  ];
}
