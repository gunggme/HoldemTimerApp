import 'package:get/get.dart';
import '../modules/timer/views/timer_view.dart';
import '../modules/timer/views/timer_setting_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.TIMER_SETTING;

  static final routes = [
    GetPage(
      name: Routes.TIMER_SETTING,
      page: () => const TimerSettingView(),
    ),
    GetPage(
      name: Routes.TIMER,
      page: () => const TimerView(),
    ),
  ];
}
