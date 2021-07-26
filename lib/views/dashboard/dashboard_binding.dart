import 'dart:async';

import 'package:getx_flutter/base/base_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardBinding());
  }

}

class DashBoardController extends BaseController {

  Rx<int> days = 0.obs;
  Rx<int> hours = 0.obs;
  Rx<int> minutes = 0.obs;
  Rx<int> seconds = 0.obs;

  @override
  void onInit() {
    super.onInit();
    MyTranslations.init();
  }

  late Timer _timer;

  void startTimer(Duration endDuration) {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        /*if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }*/
      },
    );
  }
}