import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx_flutter/base/base_controller.dart';
import 'package:getx_flutter/constants/Constant.dart';
import 'package:getx_flutter/helper/text_field.dart';
import 'package:getx_flutter/helper/text_view.dart';
import 'package:getx_flutter/views/dashboard/dashboard_binding.dart';
import 'package:getx_flutter/x_res/my_res.dart';

class DashboardScreen extends StatelessWidget {
  final _ctrl = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    _ctrl.startTimer(DateTime.now().add(Duration(seconds: 3)));

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: <Color>[darkPurpleColor, lightPurpleColor],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _headerView(),
              _timerView(),
              _entryView(),
              Container(
                padding: EdgeInsets.symmetric(vertical: MySpace.spaceM),
                height: 3,
                decoration: BoxDecoration(
                  color: lightWhiteTextColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              _myEntryList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerView() {
    return Obx(
      () => AnimatedOpacity(
        opacity: _ctrl.isHeaderVisible.value ? 1 : 0,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 1000),
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
              fontSize: 24,
            ),
            SizedBox(
              height: MySpace.spaceL,
            ),
            TextView(
              playNowChanceText,
              textColor: whiteColor.withOpacity(.7),
              fontSize: 16,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MySpace.spaceXL,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MySpace.spaceXL, vertical: MySpace.spaceL),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(MySpace.spaceL)),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    whiteColor.withOpacity(0.1),
                    lightPurpleColor.withOpacity(0.5)
                  ],
                ),
              ),
              child: Row(
                children: [
                  TextView(
                    jackpotText,
                    fontWeight: FontWeight.bold,
                    textColor: whiteColor,
                    fontSize: 20,
                  ),
                  Spacer(),
                  TextView(
                    "\$",
                    fontWeight: FontWeight.bold,
                    textColor: whiteColor,
                    fontSize: 18,
                  ),
                  SizedBox(
                    width: MySpace.spaceS,
                  ),
                  TextView(
                    "50",
                    fontWeight: FontWeight.bold,
                    textColor: whiteColor,
                    fontSize: 30,
                  ),
                ],
              ),
            ),
          ],
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
          fontSize: 30,
        ),
        TextView(
          des,
          textColor: yellowBgColor,
          fontSize: 20,
        )
      ],
    );
  }

  Widget _entryView() {
    return Padding(
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
            fontSize: 18,
          ),
        ],
      ),
    );
  }

  Widget _myEntryList() {
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
                fontSize: 20,
              ),
              SizedBox(width: MySpace.spaceL,),
              TextView(
                myEntriesText,
                fontWeight: FontWeight.bold,
                textColor: whiteColor,
                fontSize: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
