import 'dart:async';

import 'package:getx_flutter/base/base_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardBinding());
  }
}