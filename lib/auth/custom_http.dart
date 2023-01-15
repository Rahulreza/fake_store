import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fakestore/model/all_order_model.dart';
import 'package:fakestore/widgets/common_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomHttpRequest{
  static Future<Map<String,String>> getHeaderWithToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var header = {
      "Accept": "application/json",
      "Authorization": "bearer ${sharedPreferences.getString("token")}"
    };
    print("Saved Token is ${sharedPreferences.getString("token")}");
    return header;
  }



static Future<List<OrderModel>> fetchAllOrders() async {
List<OrderModel> orderList = [];
OrderModel orderModel;
String uriLink = "${baseUrl}products/";
var response = await http.get(Uri.parse(uriLink),
headers: await CustomHttpRequest.getHeaderWithToken());
print("data areeeeeeeeeeeee${response.body}");
var data = jsonDecode(response.body);
for (var i in data) {
orderModel = OrderModel.fromJson(i);
orderList.add(orderModel);
}
return orderList;
}
}