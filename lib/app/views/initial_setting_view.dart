import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:holdemtimerapp/app/constants/app_corlors.dart';
import 'package:holdemtimerapp/app/routes/app_pages.dart';
import '../controllers/initial_setting_controller.dart';

class InitialSettingView extends GetView<InitialSettingController> {
  const InitialSettingView({Key? key}) : super(key: key);

  TextStyle get normalText => const TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none,
      );

  @override
  Widget build(BuildContext context) {
    // 세로 모드로 고정
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Dealer Desk',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: false,
            backgroundColor: AppColors.black,
          ),
          backgroundColor: AppColors.black,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IP 주소 입력 필드
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "중앙제어 주소",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: "*",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: AppColors.darkGrey,
                        child: TextField(
                          controller: controller.ipController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintText: '중앙 제어 주소를 입력 해주세요',
                            hintStyle: const TextStyle(color: AppColors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: AppColors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: AppColors.primary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // IP 확인 버튼
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.connectToServer();
                      Get.offAllNamed(Routes.TIMER);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: const Text(
                      '연결 요청',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: controller.isConnectionWaiting.value,
            child: Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColors.black.withOpacity(0.5),
                child: Center(
                    child: Text(
                  "연결 요청 중 입니다.",
                  style: normalText,
                ))),
          ),
        ),
      ],
    );
  }
}
