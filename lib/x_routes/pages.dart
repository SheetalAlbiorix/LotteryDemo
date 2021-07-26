import 'package:get/get.dart';
import 'package:getx_flutter/views/dashboard/dashboard_binding.dart';
import 'package:getx_flutter/views/dashboard/dashboard_screen.dart';

import 'router_name.dart';

class Pages {
  static List<GetPage> pages() {
    return [
      GetPage(
          name: RouterName.dashboard,
          page: () => DashboardScreen(),
          binding: DashboardBinding()
      ),
    ];
  }
}