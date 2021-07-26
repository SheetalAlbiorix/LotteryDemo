import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:getx_flutter/constants/Constant.dart';

class Utilities {

  void logWhenDebug(String tag,String message){
    if (kDebugMode)
      log("$tag => ${message.toString()}", name: weeklyLotteryText);
  }

}
