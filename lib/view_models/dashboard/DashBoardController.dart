import 'dart:async';
import 'dart:math';

import 'package:getx_flutter/base/base_view_view_model.dart';
import 'package:getx_flutter/models/listData.dart';

class DashBoardController extends BaseController {
  Rx<int> days = 0.obs;
  Rx<int> hours = 0.obs;
  Rx<int> minutes = 0.obs;
  Rx<int> seconds = 0.obs;

  Rx<bool> isHeaderVisible = true.obs;

  Rx<double> textSize = 30.0.obs;

  Rx<double> value1 = 0.0.obs;
  Rx<double> value2 = 0.0.obs;
  Rx<double> value3 = 0.0.obs;

  int rollerCount = 0;

  RxList listData = [
    ListData(title: "99", isSelected: false),
    ListData(title: "03", isSelected: false),
    ListData(title: "36", isSelected: false),
    ListData(title: "16", isSelected: false),
    ListData(title: "17", isSelected: false),
    ListData(title: "88", isSelected: false),
    ListData(title: "16", isSelected: false),
    ListData(title: "22", isSelected: false),
    ListData(title: "65", isSelected: false),
    ListData(title: "41", isSelected: false),
    ListData(title: "98", isSelected: false),
    ListData(title: "12", isSelected: false),
  ].obs;

  Rx<String> selectedNumber = "0".obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    //startTimer(DateTime.now().add(Duration(seconds: 6)));
  }

  @override
  void onClose() {
    _timer!.cancel();
    super.onClose();
  }

  void startTimer(DateTime endTime) async {
    DateTime _now = DateTime.now();
    int timerMaxSeconds = 0;

    if (_now.isBefore(endTime)) {
      timerMaxSeconds = endTime.difference(_now).inSeconds;

      _timer = new Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) async {
          Duration diff = endTime.difference(_now);

          days.value = diff.inDays;
          hours.value = diff.inHours;
          minutes.value = diff.inMinutes;
          seconds.value = diff.inSeconds;

          endTime = endTime.add(Duration(seconds: -1));

          if (timer.tick > timerMaxSeconds) {
            isHeaderVisible.value = false;
            timer.cancel();
            await Future.delayed(
              Duration(seconds: 2),
              () => {
                startRoller(value1),
              },
            );
          }
        },
      );
    }
  }

  void startRoller(Rx<double> value) {
    int timerMaxSeconds = 20;
    var rng = new Random();

    _timer = new Timer.periodic(
      Duration(milliseconds: 100),
      (Timer timer) async {
        value.value = rng.nextInt(99).toDouble() + 1;
        if (timer.tick > timerMaxSeconds) {
          timer.cancel();
          if (rollerCount == 0) {
            value.value = 16;
          } else if (rollerCount == 1) {
            value.value = 22;
          } else if (rollerCount == 2) {
            value.value = 65;
          }
          await Future.delayed(
            Duration(seconds: 1),
            () => {
              if (rollerCount == 0)
                {
                  value.value = 16,
                  startListItemAnimation("16"),
                }
              else if (rollerCount == 1)
                {
                  value.value = 22,
                  startListItemAnimation("22"),
                }
              else if (rollerCount == 2)
                {
                  value.value = 65,
                  startListItemAnimation("65"),
                }
            },
          );
        }
      },
    );
  }

  void startListItemAnimation(String value) async {
    selectedNumber.value = value;
    listData.asMap().forEach(
          (index, item) => {
            if (item.title == value)
              {
                textSize.value = 60.0,
                listData[index].isSelected = true,
                listData[index].isAnimated = true,
              }
          },
        );
    await Future.delayed(
      Duration(seconds: 2),
      () => {
        rollerCount++,
        stopListItemAnimation(),
      },
    );
  }

  void stopListItemAnimation() async {
    textSize.value = 30.0;
    await Future.delayed(
      Duration(seconds: 1),
      () => {
        listData.asMap().forEach(
              (index, item) => {
                if (item.title == selectedNumber.value)
                  {
                    listData[index].isSelected = false,
                  }
              },
            ),
        if (rollerCount == 1)
          {startRoller(value2)}
        else if (rollerCount == 2)
          {startRoller(value3)}
        else {

          }
      },
    );
  }
}
