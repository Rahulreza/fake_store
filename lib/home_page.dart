import 'dart:convert';

import 'package:fakestore/add_new_product.dart';
import 'package:fakestore/add_product.dart';
import 'package:fakestore/auth/custom_http.dart';
import 'package:fakestore/model/all_order_model.dart';
import 'package:fakestore/peovider/order_provider.dart';
import 'package:fakestore/profile/user_profile.dart';
import 'package:fakestore/widgets/color.dart';
import 'package:fakestore/widgets/common_widgets.dart';
import 'package:fakestore/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<OrderModel> orderList = [];
  fetchAllOrder() async {
    OrderModel orderModel;
    String uriLink = "${baseUrl}products/";
    var response = await http.get(Uri.parse(uriLink),
        headers: await CustomHttpRequest.getHeaderWithToken());
    print("data areeeeeeeeeeeee${response.body}");
    var data = jsonDecode(response.body);
    for (var i in data) {
      orderModel = OrderModel.fromJson(i);
      setState(() {
        orderList.add(orderModel);
      });
    }
  }

  @override
  void initState() {
    fetchAllOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dialogBGColor,
        leading: Icon(
          Icons.menu,
          size: 25,
        ),
        title: Text(
          'Fake Store',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            iconSize: 25,
            icon: Icon(
              Icons.person,
            ),
            onPressed: () {
              setState(
                () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserProfilePage()));
                },
              );
            },
          ),
          // GestureDetector(
          //     onTap: () {},
          //     child: Padding(
          //       padding:  EdgeInsets.only(top: 18, right: 10),
          //       child: Text('SignUp'),
          //     ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        backgroundColor: boxColor,
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
        // onPressed: () {
        //   showModalBottomSheet(context: context, builder: (context){
        //     return  AddProduct();
        //   });
        // },
        onPressed: (){
          setState(
                () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNewProductPage()));
            },
          );
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: orderList.length,
              itemBuilder: (BuildContext ctx, index) {
                return Container(

                  margin: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: boxFontColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [

                         Expanded(
                           flex: 4,
                           child: ClipRRect(
                             borderRadius: BorderRadius.circular(10),

                             child: Image.network(
                                "${orderList[index].category!.image}",
                                fit: BoxFit.cover,
                              width: 100,
                              height: 80,
                        ),
                           ),
                         ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("ID: ${orderList[index].category!.id}",
                                style: myStyle(10, fontColor)),
                            Text(
                                "Product Name: ${orderList[index].category!.name}",
                                style: myStyle(10, fontColor)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          " ${orderList[index].title}",
                          style: myStyle(11, dialogBGColor, FontWeight.bold),
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: Container(

                          child: Center(
                              child: Text(
                            "Price: ${orderList[index].price}",
                            style: myStyle(12, fontColor),
                          )),
                          height: 15,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: boxColor),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
