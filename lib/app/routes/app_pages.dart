import 'package:get/get.dart';
import 'package:holdemtimerapp/app/binding/timer_binding.dart';
import '../views/timer_view.dart';
import '../views/initial_setting_view.dart';
import '../views/ingame_setting_view.dart';
import '../views/waiting_room_view.dart';
import '../binding/initial_setting_binding.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INITIAL_SETTING;

  static final routes = [
    GetPage(
      name: Routes.INITIAL_SETTING,
      page: () => const InitialSettingView(),
      binding: InitialSettingBinding(),
    ),
    GetPage(
      name: Routes.WAITING_ROOM,
      page: () => const WaitingRoomView(),
    ),
    GetPage(
      name: Routes.TIMER,
      page: () => const TimerView(),
      binding: TimerBinding(),
    ),
    GetPage(
      name: Routes.INGAME_SETTING,
      page: () => const InGameSettingView(),
    ),
  ];
}
