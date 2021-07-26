import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx_flutter/base/base_controller.dart';
import 'package:getx_flutter/constants/Constant.dart';
import 'package:getx_flutter/helper/text_field.dart';
import 'package:getx_flutter/helper/text_view.dart';
import 'package:getx_flutter/view_models/dashboard/DashBoardController.dart';
import 'package:getx_flutter/x_res/my_res.dart';
import 'package:lottie/lottie.dart';
import 'package:roller_list/roller_list.dart';

class DashboardScreen extends StatefulWidget{
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with TickerProviderStateMixin{
  final _ctrl = Get.put(DashBoardController());
  List<String> arEntry = ["99","03","36","16","17","88","16","22","05","41","98","12"];

  final leftRoller = new GlobalKey<RollerListState>();
  final rightRoller = new GlobalKey<RollerListState>();
  final fourthRoller = new GlobalKey<RollerListState>();
  Timer? rotator;
  var _ROTATION_DURATION = Duration(milliseconds: 300);
  final List<Widget> slots = _getSlots();
  Random _random = new Random();
  int? first = 0, second = 0, third = 0;

  @override
  Widget build(BuildContext context) {
    //_ctrl.startTimer(DateTime.now().add(Duration(seconds: 3)));

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
              // colors: <Color>[darkPurpleColor, lightPurpleColor],
              colors: <Color>[lightPurpleColor1,lightBorderColor1],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _headerView(),
                _timerView(),
                // _crackerShow(),
                 slotMachine(),
                GestureDetector(
                  onTap: (){
                    _startRotating();
                  },
                    child: TextView("click me",textColor: Colors.white,fontSize: 25,)),
                //_crackerShow(),
                _entryView(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: MySpace.spaceM),
                  height: 3,
                  decoration: BoxDecoration(
                    color: lightWhiteTextColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
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
        //opacity: _ctrl.isHeaderVisible.value ? 1 : 0,
        curve: Curves.easeInOut,
        duration: Duration(seconds: 1),
        vsync: this,
        child: SizedBox(
          height: _ctrl.isHeaderVisible.value ? 220 : 0,
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
    return Obx(
          () => AnimatedSize(
        //opacity: _ctrl.isHeaderVisible.value ? 1 : 0,
        curve: Curves.easeInOut,
        duration: Duration(seconds: 1),
        vsync: this,
        child: SizedBox(
          height: _ctrl.isHeaderVisible.value ? 220 : 0,
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
                  fontSize: 18,
                ),
              ],
            ),
          ),
        ),
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
          ),
          SizedBox(height: 10),
          entryGridList(context)
        ],
      ),
    );
  }

  Widget entryGridList(BuildContext context){
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: arEntry.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 2 / (3 * MediaQuery.of(context).textScaleFactor/2.5),
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0
      ),
      itemBuilder: (BuildContext context, int index){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: lightBorderColor,width: 3),

          ),
          child: Align(alignment:Alignment.center,child: TextView(arEntry[index],textColor: whiteColor,fontSize: 30)),
        );
      },
    );
  }

  Widget _crackerShow() {
    return Lottie.asset('assets/json/success.json');
  }

  Widget slotMachine() {
    return Container(
      width: double.infinity,
      height: 40,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: RollerList(
              items: slots,
              enabled: false,
              key: leftRoller,
              onSelectedIndexChanged: (value) {
                /*setState(() {
                  first = value - 1;
                });*/
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
                /*setState(() {
                  second = value - 1;
                });*/
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
                /* setState(() {
                  third = value - 1;
                });*/
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
                /*setState(() {
                  fourth = value - 1;
                });*/
              },
            ),
          ),
        ],
      ),
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
        child: TextView(
          i.toString(),
          fontSize: 10,
        ),
      ));
    }
    return result;
  }

  /*_winDialog(){
    Get.defaultDialog(
        backgroundColor:yellowBgColor,
        title: "",
        radius: 20,
        content: Container(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.close,color: blackTextColor,),
              )
            ],
          ),

        )
    );
  }*/

  _winDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              // backgroundColor: yellowBg1Color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
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
                        colors: [yellowBgColor,gradientyellow2Color]
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Image.asset("assets/images/gift.png",
                            height: 100, width: 100),
                        SizedBox(height: 20),
                        Text(youWonText,
                            style: TextStyle(
                                color: blackTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: EdgeInsets.only(left: 55,right: 55,top: 15,bottom: 15),
                            decoration: BoxDecoration(
                              color: yellowBgColor,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Text("\$50",
                                style: TextStyle(
                                    color: blackTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25))
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(whatsNextText,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: blackTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ),
                        Text(yourEmployerText,
                            style: TextStyle(
                                color: blackTextColor,
                                fontSize: 14)),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Icon(
                        Icons.close,
                        color: blackTextColor,
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}
