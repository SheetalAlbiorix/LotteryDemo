import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../x_utils/utilities.dart';
import 'base_common_widgets.dart';
import 'widget_state.dart';

export 'package:get/get.dart';

export '../x_res/my_res.dart';

class BaseController extends GetxController
    with BaseCommonWidgets, Utilities /*Repositories*/, WidgetState, ScreenState {
  final box = GetStorage();
  bool isLoadMore = false;
  bool withScrollController = false;
  late ScrollController scrollController;

  set setEnableScrollController(bool value) => withScrollController = value;

  @override
  void onInit() {
    super.onInit();
    if (withScrollController) {
      logWhenDebug("SCROLL CONTROLLER ENABLE on ${Get.currentRoute}",
          withScrollController.toString());
      scrollController = ScrollController();
      scrollController.addListener(_scrollListener);
    }
  }

  void onRefresh() {}
  
  void onLoadMore() {}

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if(!isLoadMore) {
        isLoadMore = true;
        update();
        onLoadMore();
      }
    }
    _innerBoxScrolled();
  }
  
  void _innerBoxScrolled() {
    if(scrollController.offset <= 60 && scrollController.offset > 40) {
    }
    if(scrollController.offset >= 0 && scrollController.offset <= 40) {
    }
  } 

}
