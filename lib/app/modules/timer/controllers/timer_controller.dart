import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerController extends GetxController with GetSingleTickerProviderStateMixin {
  final RxInt initialMinutes = 1.obs;
  final RxInt initialSeconds = 0.obs;

  final RxInt testLevelValue = 1.obs;
  
  final RxInt minutes = 1.obs;
  final RxInt seconds = 0.obs;
  final RxBool isRunning = false.obs;
  final RxBool isStarted = false.obs;
  Timer? _timer;
  
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  final Rx<double> animatedProgress = 0.0.obs;

  final RxInt currentPlayers = 10.obs;
  final RxInt maxPlayers = 12.obs;
  final RxInt entries = 10.obs;
  final RxInt rebuys = 0.obs;
  final RxInt addOns = 0.obs;

  final RxInt totalChips = 15000000.obs;
  final RxInt totalPrize = 1330000.obs;

  void incrementPlayers() {
    if (currentPlayers < maxPlayers.value) {
      currentPlayers.value++;
      _updateTotalChipsAndPrize();
    }
  }

  void decrementPlayers() {
    if (currentPlayers > 0) {
      currentPlayers.value--;
      _updateTotalChipsAndPrize();
    }
  }

  void incrementEntries() {
    entries.value++;
    _updateTotalChipsAndPrize();
  }

  void decrementEntries() {
    if (entries > 0) {
      entries.value--;
      _updateTotalChipsAndPrize();
    }
  }

  void incrementRebuys() {
    rebuys.value++;
    _updateTotalChipsAndPrize();
  }

  void decrementRebuys() {
    if (rebuys > 0) {
      rebuys.value--;
      _updateTotalChipsAndPrize();
    }
  }

  void incrementAddOns() {
    addOns.value++;
    _updateTotalChipsAndPrize();
  }

  void decrementAddOns() {
    if (addOns > 0) {
      addOns.value--;
      _updateTotalChipsAndPrize();
    }
  }

  void _updateTotalChipsAndPrize() {
    int baseChips = 1500000;
    totalChips.value = baseChips * entries.value;
    totalPrize.value = (totalChips.value * 0.1).round();
  }

  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _progressAnimation.addListener(() {
      animatedProgress.value = _progressAnimation.value;
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    _animationController.dispose();
    super.onClose();
  }

  void setInitialTime() {
    minutes.value = initialMinutes.value;
    seconds.value = initialSeconds.value;
    resetTimer();
  }

  void startTimer() {
    if (!isRunning.value) {
      isRunning.value = true;
      if (!isStarted.value) {
        isStarted.value = true;
      }
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (seconds.value > 0) {
          seconds.value--;
        } else if (minutes.value > 0) {
          minutes.value--;
          seconds.value = 59;
        } else {
          stopTimer();
        }
        _updateProgress();
      });
      _updateProgress();
    }
  }

  void stopTimer() {
    isRunning.value = false;
    _timer?.cancel();
  }

  void resetTimer() {
    stopTimer();
    isStarted.value = false;
    minutes.value = initialMinutes.value;
    seconds.value = initialSeconds.value;
    animatedProgress.value = 0.0;
    _updateProgress();
  }

  void _updateProgress() {
    if (!isStarted.value) return;
    
    final totalSeconds = (initialMinutes.value * 60 + initialSeconds.value);
    final currentSeconds = (minutes.value * 60 + seconds.value);
    final targetProgress = 1.0 - (currentSeconds / totalSeconds);

    _progressAnimation = Tween<double>(
      begin: animatedProgress.value,
      end: targetProgress,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward(from: 0.0);
  }

  double getProgress() {
    if (!isStarted.value) return 1.0;
    return animatedProgress.value;
  }
} 