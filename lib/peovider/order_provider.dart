import 'package:fakestore/auth/custom_http.dart';
import 'package:fakestore/model/all_order_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> orderList = [];

  getOrderData() async {

    orderList = await CustomHttpRequest.fetchAllOrders();
    notifyListeners();
  }
}
