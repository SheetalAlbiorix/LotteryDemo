import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx_flutter/constants/Constant.dart';
import 'package:getx_flutter/helper/text_view.dart';
import 'package:getx_flutter/x_res/my_res.dart';
import 'package:lottie/lottie.dart';
import 'package:roller_list/roller_list.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final leftRoller = new GlobalKey<RollerListState>();
  final rightRoller = new GlobalKey<RollerListState>();
  final fourthRoller = new GlobalKey<RollerListState>();
  Timer? rotator;
  static const _ROTATION_DURATION = Duration(milliseconds: 300);
  final List<Widget> slots = _getSlots();
  Random _random = new Random();
  int? first, second, third, fourth;

  @override
  void initState() {
    first = 0;
    second = 0;
    third = 0;
    fourth = 0;
    super.initState();
  }

  @override
  void dispose() {
    rotator?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              _crackerShow(),
              /*  slotMachine(),
              GestureDetector(
                onTap: (){
                  _startRotating();
                },
                  child: TextView("click me",textColor: Colors.white,fontSize: 25,))*/
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerView() {
    return Column(
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
                width: 5,
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
    );
  }

  Widget _timerView() {
    return Column(
      children: [
        SizedBox(
          height: MySpace.spaceXL,
        ),
        Row(
          children: [],
        ),
        SizedBox(
          height: MySpace.spaceXL,
        ),
      ],
    );
  }

  Widget _crackerShow() {
    return Lottie.asset('assets/json/success.json');
  }

  Widget slotMachine() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: RollerList(
            items: slots,
            enabled: false,
            key: leftRoller,
            onSelectedIndexChanged: (value) {
              setState(() {
                first = value - 1;
              });
            },
          ),
        ),
        VerticalDivider(
          width: 2,
          color: Colors.black,
        ),
        Expanded(
          flex: 1,
          child: RollerList(
            items: slots,
            scrollType: ScrollType.goesOnlyBottom,
            onSelectedIndexChanged: (value) {
              setState(() {
                second = value - 1;
              });
              _finishRotating();
            },
            onScrollStarted: _startRotating,
          ),
        ),
        VerticalDivider(
          width: 2,
          color: Colors.black,
        ),
        Expanded(
          flex: 1,
          child: RollerList(
            enabled: false,
            items: slots,
            key: rightRoller,
            onSelectedIndexChanged: (value) {
              setState(() {
                third = value - 1;
              });
            },
          ),
        ),
        VerticalDivider(
          width: 2,
          color: Colors.black,
        ),
        Expanded(
          flex: 1,
          child: RollerList(
            enabled: false,
            items: slots,
            key: fourthRoller,
            onSelectedIndexChanged: (value) {
              setState(() {
                fourth = value - 1;
              });
            },
          ),
        ),
      ],
    );
  }

  void _startRotating() {
    rotator = Timer.periodic(_ROTATION_DURATION, _rotateRoller);
  }

  void _rotateRoller(_) {
    final leftRotationTarget = _random.nextInt(3 * slots.length);
    final rightRotationTarget = _random.nextInt(3 * slots.length);
    leftRoller.currentState?.smoothScrollToIndex(leftRotationTarget,
        duration: _ROTATION_DURATION, curve: Curves.linear);
    rightRoller.currentState?.smoothScrollToIndex(rightRotationTarget,
        duration: _ROTATION_DURATION, curve: Curves.linear);
    fourthRoller.currentState?.smoothScrollToIndex(rightRotationTarget,
        duration: _ROTATION_DURATION, curve: Curves.linear);
  }

  void _finishRotating() {
    rotator?.cancel();
  }

  static List<Widget> _getSlots() {
    List<Widget> result = [];
    for (int i = 0; i <= 9; i++) {
      result.add(Container(
        padding: EdgeInsets.all(15.0),
        color: Colors.white,
        child: Image.asset(
          XR().assetsImage.img_logo,
          width: 25,
          height: 25,
        ),
        //   TextView(i.toString()),
      ));
    }
    return result;
  }
}
