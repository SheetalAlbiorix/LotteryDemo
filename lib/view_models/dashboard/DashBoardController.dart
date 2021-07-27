import 'dart:async';

import 'package:getx_flutter/base/base_view_view_model.dart';
import 'package:getx_flutter/models/listData.dart';

class DashBoardController extends BaseController {
  Rx<int> days = 0.obs;
  Rx<int> hours = 0.obs;
  Rx<int> minutes = 0.obs;
  Rx<int> seconds = 0.obs;

  Rx<bool> isHeaderVisible = true.obs;

  Rx<double> textSize = 30.0.obs;

  RxList listData = [
    ListData(title: "99", isSelected: false),
    ListData(title: "03", isSelected: false),
    ListData(title: "36", isSelected: false),
    ListData(title: "16", isSelected: false),
    ListData(title: "17", isSelected: false),
    ListData(title: "88", isSelected: false),
    ListData(title: "16", isSelected: false),
    ListData(title: "22", isSelected: false),
    ListData(title: "05", isSelected: false),
    ListData(title: "41", isSelected: false),
    ListData(title: "98", isSelected: false),
    ListData(title: "12", isSelected: false),
  ].obs;

  Rx<String> selectedNumber = "0".obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer(DateTime.now().add(Duration(seconds: 3)));
  }

  @override
  void onClose() {
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

  void startItemAnimation(String value) {
    selectedNumber.value = value;
    listData.asMap().forEach((index, item) => {
      if(item.title == value){
        listData[index].isSelected = true,
        textSize.value = 60.0,
        listData[index].isAnimated = true,
      }
    });
  }

  void stopItemAnimation() async{
    textSize.value = 30.0;
    await Future.delayed(const Duration(seconds: 1), (){
      listData.asMap().forEach((index, item) => {
        if(item.title == selectedNumber.value){
          listData[index].isSelected = false,
        }
      });
    });
  }
}
