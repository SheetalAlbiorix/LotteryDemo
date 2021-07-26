import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/constants/Constant.dart';
import 'package:getx_flutter/helper/text_view.dart';
import 'package:getx_flutter/x_res/my_res.dart';
import 'package:lottie/lottie.dart';

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
            children: [_headerView(), _timerView(), _crackerShow()],
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
        GestureDetector(
          onTap: () {
            _winDialog(context);
          },
          child: TextView(
            weeklyLotteryText.toUpperCase(),
            fontWeight: FontWeight.bold,
            textColor: whiteColor,
            fontSize: 24,
          ),
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
