import 'package:getx_flutter/base/base_controller.dart';

class ProductController extends BaseController {
  var productName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    productName.value = "Testing";
  }

}