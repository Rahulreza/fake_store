import 'package:fakestore/model/usersModelClass.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fakestore/auth/custom_http.dart';
import 'package:fakestore/model/all_order_model.dart';
import 'package:fakestore/peovider/order_provider.dart';
import 'package:fakestore/widgets/color.dart';
import 'package:fakestore/widgets/common_widgets.dart';
import 'package:fakestore/widgets/constant.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  List<UserModelClass> userTotalList = [];
  fetchAllUser() async {
    UserModelClass userModelClass;
    String uriLink = "${baseUrl}users/";
    var response = await http.get(Uri.parse(uriLink),
        headers: await CustomHttpRequest.getHeaderWithToken());
    print("User List${response.body}");
    var data = jsonDecode(response.body);
    for (var i in data) {
      userModelClass = UserModelClass.fromJson(i);
      setState(() {
        userTotalList.add(userModelClass);
      });
    }
  }
  @override
  void initState(){
    fetchAllUser();
  }


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: dialogBGColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 25,),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body:Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage("${userTotalList[0].avatar}"),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Name: ${userTotalList[0].name}", style: myStyle(24, fontColor)),
              SizedBox(
                height: 10,
              ),
              Text("Role: ${userTotalList[0].role}", style: myStyle(14, fontColor)),
              SizedBox(
                height: 10,
              ),
              Text("Email: ${userTotalList[0].email}", style: myStyle(14, fontColor)),
              SizedBox(
                height: 10,
              ),
              Text("Password: ${userTotalList[0].password}", style: myStyle(14, fontColor)),
              SizedBox(
                height: 10,
              ),
              Text("Creation Profile: ${userTotalList[0].creationAt}", style: myStyle(14, fontColor)),
              SizedBox(
                height: 10,
              ),
              Text("Updated Profile: ${userTotalList[0].updatedAt}", style: myStyle(14, fontColor)),
            ],
          ),
        ),
      )
    );
  }
}
