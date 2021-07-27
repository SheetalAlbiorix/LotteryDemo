import 'dart:async';
import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:getx_flutter/base/base_view_view_model.dart';
import 'package:getx_flutter/constants/Constant.dart';
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

  AnimationController? controller;

  Rx<bool> isFinish = false.obs;

  BuildContext? context;

  @override
  void onInit() {
    super.onInit();
    startTimer(DateTime.now().add(Duration(seconds: 6)));
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
      () async => {
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
        else
          {
            controller?.status == AnimationStatus.completed
                ? controller?.reverse()
                : controller?.forward(),
            isFinish.value = true,
            await Future.delayed(
              Duration(seconds: 2),
              () => {
                isFinish.value = false,
                _winDialog(context!),
              },
            ),
          }
      },
    );
  }

  _winDialog(BuildContext context) {
    return showAnimatedDialog(
      context: context,
      animationType: DialogTransitionType.slideFromBottom,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          contentPadding: EdgeInsets.only(top: 0.0, left: 0.0, right: 0),
          content: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(25),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [yellowBgColor, gradientyellow2Color]),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 30),
                    Image.asset(
                      "assets/images/gift.png",
                      height: 110,
                      width: 120,
                    ),
                    SizedBox(height: 20),
                    Text(
                      youWonText,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: blackTextColor,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.only(
                          left: 75, right: 75, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: yellowBgColor,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        "\$50",
                        style: TextStyle(
                            color: blackTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 35),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        whatsNextText,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: blackTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      yourEmployerText,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: grayBgColor,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 15.0,
                right: 20.0,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.close,
                    color: blackTextColor,
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
