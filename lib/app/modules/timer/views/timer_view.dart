import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';
import '../widgets/timer_display.dart';
import '../widgets/timer_controls.dart';

class TimerView extends GetView<TimerController> {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){ Get.back(); controller.resetTimer();}, icon: Icon(Icons.arrow_back, color: Colors.white, size: 32,), ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(

            child: Text("Blinds", style: TextStyle(color: Colors.white),),
          ),
          Stack(
            children: [
              // 메인 타이머 영역
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TimerDisplay(
                        controller: controller,
                        size: 250,
                      ),
                      TimerControls(
                        controller: controller,
                        showBackButton: false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
} 