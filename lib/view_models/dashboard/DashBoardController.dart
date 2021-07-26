import 'dart:async';

import 'package:getx_flutter/base/base_view_view_model.dart';

class DashBoardController extends BaseController {
  Rx<int> days = 0.obs;
  Rx<int> hours = 0.obs;
  Rx<int> minutes = 0.obs;
  Rx<int> seconds = 0.obs;

  Rx<bool> isHeaderVisible = true.obs;

  Timer? _timer;
  @override
  void onInit() {
    super.onInit();
    startTimer(DateTime.now().add(Duration(seconds: 3)));
  }


  @override
  void onClose(){
    _timer!.cancel();
    super.onClose();
  }

  void startTimer(DateTime endTime) {
    DateTime _now = DateTime.now();
    int timerMaxSeconds = 0;

    if (_now.isBefore(endTime)) {

      timerMaxSeconds = endTime.difference(_now).inSeconds;

      _timer = new Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) {

          Duration diff = endTime.difference(_now);

          days.value = diff.inDays;
          hours.value = diff.inHours;
          minutes.value = diff.inMinutes;
          seconds.value = diff.inSeconds;

          endTime = endTime.add(Duration(seconds: -1));

          if (timer.tick > timerMaxSeconds) {
            isHeaderVisible.value = false;
            timer.cancel();
          }
        },
      );
    }
  }
}
