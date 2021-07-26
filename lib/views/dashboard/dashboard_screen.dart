import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx_flutter/constants/Constant.dart';
import 'package:getx_flutter/helper/text_view.dart';
import 'package:getx_flutter/x_res/my_res.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
          children: [
            
          ],
        ),
        SizedBox(
          height: MySpace.spaceXL,
        ),
      ],
    );
  }
}
