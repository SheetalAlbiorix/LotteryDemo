import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getx_flutter/base/base_view_view_model.dart';
import 'package:getx_flutter/view_models/product/product_controller.dart';

class ProductWidget extends BaseViewModel<ProductController> {
  @override
  Widget vmBuilder() {
    return ListTile(
      title: Text('${controller.productName}'),
    );
  }

}