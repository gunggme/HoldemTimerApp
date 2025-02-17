import 'package:get/get.dart';
import 'package:holdemtimerapp/app/controllers/initial_setting_controller.dart';

class InitialSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InitialSettingController>(() => InitialSettingController());
  }
}
