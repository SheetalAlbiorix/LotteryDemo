import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx_flutter/base/base_controller.dart';
import 'package:getx_flutter/constants/Constant.dart';
import 'package:getx_flutter/helper/text_field.dart';
import 'package:getx_flutter/helper/text_view.dart';
import 'package:getx_flutter/view_models/dashboard/DashBoardController.dart';
import 'package:getx_flutter/x_res/my_res.dart';
import 'package:lottie/lottie.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  final _ctrl = Get.put(DashBoardController());

  late Animation<double> animation;
  late AnimationController controller;

  @override
  Widget build(BuildContext context) {
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation = Tween<double>(begin: 30, end: 40).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: MySpace.marginXL),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: <Color>[lightPurpleColor1, lightBorderColor1],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _headerView(),
                _timerView(),
                _slotMachineView(),
                _entryView(),
                _horizontalDivider(),
                _myEntryList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerView() {
    return Obx(
      () => AnimatedSize(
        curve: Curves.easeInOut,
        duration: Duration(seconds: 2),
        vsync: this,
        child: SizedBox(
          height: _ctrl.isHeaderVisible.value ? MySpace.headerHeight : 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MySpace.spaceL,
              ),
              TextView(
                weeklyLotteryText.toUpperCase(),
                fontWeight: FontWeight.bold,
                textColor: whiteColor,
                fontSize: MySpace.font24,
              ),
              SizedBox(
                height: MySpace.spaceL,
              ),
              TextView(
                playNowChanceText,
                textColor: whiteColor.withOpacity(.7),
                fontSize: MySpace.font16,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MySpace.spaceXL,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MySpace.spaceXL,
                  vertical: MySpace.spaceL,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(MySpace.spaceL),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      whiteColor.withOpacity(0.1),
                      lightPurpleColor.withOpacity(0.5),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    TextView(
                      jackpotText,
                      fontWeight: FontWeight.bold,
                      textColor: whiteColor,
                      fontSize: MySpace.font20,
                    ),
                    Spacer(),
                    TextView(
                      "\$",
                      fontWeight: FontWeight.bold,
                      textColor: whiteColor,
                      fontSize: MySpace.font18,
                    ),
                    SizedBox(
                      width: MySpace.spaceS,
                    ),
                    TextView(
                      "50",
                      fontWeight: FontWeight.bold,
                      textColor: whiteColor,
                      fontSize: MySpace.font30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _timerView() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MySpace.spaceXL),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            _timerItem(_ctrl.days, "d"),
            _timerItem(_ctrl.hours, "h"),
            _timerItem(_ctrl.minutes, "m"),
            _timerItem(_ctrl.seconds, "s"),
          ],
        ),
      ),
    );
  }

  Widget _timerItem(Rx<int> val, String des) {
    return Row(
      children: [
        TextView(
          val.toString(),
          textColor: whiteColor,
          fontSize: MySpace.font30,
        ),
        TextView(
          des,
          textColor: yellowBgColor,
          fontSize: MySpace.font20,
        )
      ],
    );
  }

  Widget _slotMachineView() {
    return Obx(
      () => AnimatedSize(
        vsync: this,
        curve: Curves.easeIn,
        duration: Duration(seconds: 2),
        child: Column(
          children: [
            TextView(
              thisWeekWinningNumberText,
              textColor: Colors.white,
              fontSize: MySpace.font20,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MySpace.spaceM,
            ),
            Container(
              width: double.infinity,
              //height: MySpace.spinnerItemHeight,
              height: !_ctrl.isHeaderVisible.value ? MySpace.spinnerItemHeight : 0,
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  _spinnerItem(_ctrl.value1),
                  _spinnerDivider(),
                  _spinnerItem(_ctrl.value2),
                  _spinnerDivider(),
                  _spinnerItem(_ctrl.value3),
                ],
              ),
            ),
            SizedBox(
              height: MySpace.spaceM,
            ),
          ],
        ),
      ),
    );
  }

  Widget _spinnerItem(Rx<double> value) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          color: darkPurpleColor,
          borderRadius: BorderRadius.all(Radius.circular(MySpace.spaceM)),
          border: Border.all(color: lightBorderColor, width: 3),
        ),
        child: value.value > 0
            ? AnimatedFlipCounter(
                duration: Duration(seconds: 1),
                value: value.value,
                textStyle:
                    TextStyle(color: whiteColor, fontSize: MySpace.font30),
              )
            : SizedBox(
                height: MySpace.spinnerItemHeight,
              ),
      ),
    );
  }

  Widget _spinnerDivider() {
    return VerticalDivider(
      width: MySpace.spaceM,
      color: Colors.black,
    );
  }

  Widget _entryView() {
    return Obx(
      () => AnimatedSize(
        curve: Curves.easeInOut,
        duration: Duration(seconds: 2),
        vsync: this,
        child: SizedBox(
          height: _ctrl.isHeaderVisible.value ? MySpace.headerHeight : 0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: MySpace.spaceXL),
            child: Column(
              children: [
                CustomTextField(
                  hint: submitEntryText,
                ),
                SizedBox(
                  height: MySpace.spaceM,
                ),
                TextView(
                  "0 ${remainingText.toLowerCase()}",
                  textColor: whiteColor,
                  fontSize: MySpace.font18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _horizontalDivider() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: MySpace.spaceM),
      height: 3,
      decoration: BoxDecoration(
        color: lightWhiteTextColor,
        borderRadius: BorderRadius.all(Radius.circular(MySpace.spaceM)),
      ),
    );
  }

  Widget _myEntryList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MySpace.spaceXL),
      child: Column(
        children: [
          Row(
            children: [
              TextView(
                myEntriesText,
                fontWeight: FontWeight.bold,
                textColor: whiteColor,
                fontSize: MySpace.font20,
              ),
              SizedBox(
                width: MySpace.spaceL,
              ),
              Container(
                height: MySpace.spaceXL,
                width: MySpace.spaceXL,
                decoration: new BoxDecoration(
                  color: yellowBgColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: TextView(
                    "4",
                    fontWeight: FontWeight.bold,
                    textColor: blackTextColor,
                    fontSize: MySpace.font20,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MySpace.spaceM),
          entryGridList(context),
        ],
      ),
    );
  }

  Widget entryGridList(BuildContext context) {
    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _ctrl.listData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio:
              2 / (3 * MediaQuery.of(context).textScaleFactor / 2.5),
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(MySpace.spaceM)),
              border: Border.all(color: lightBorderColor, width: 3),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Center(
                    child: AnimatedDefaultTextStyle(
                      child: Text(_ctrl.listData[index].title!),
                      style: TextStyle(
                        color: _ctrl.listData[index].isAnimated
                            ? yellowBgColor
                            : whiteColor,
                        fontSize: _ctrl.listData[index].isSelected!
                            ? _ctrl.textSize.value
                            : MySpace.font30,
                      ),
                      duration: Duration(seconds: 1),
                    ),
                  ),
                  _ctrl.listData[index].isSelected!
                      ? Center(
                          child: Image.asset(
                            "assets/gif/fire.gif",
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _crackerShow() {
    return Lottie.asset('assets/json/success.json');
  }

  _winDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          contentPadding: EdgeInsets.only(top: 0.0),
          content: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [yellowBgColor, gradientyellow2Color]),
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Image.asset(
                      "assets/images/gift.png",
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(height: 20),
                    Text(
                      youWonText,
                      style: TextStyle(
                          color: blackTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 55, right: 55, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                          color: yellowBgColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(
                          "\$50",
                          style: TextStyle(
                              color: blackTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
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
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text(
                      yourEmployerText,
                      style: TextStyle(
                        color: blackTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10.0,
                right: 10.0,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.close,
                    color: blackTextColor,
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
