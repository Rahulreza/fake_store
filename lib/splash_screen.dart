import 'package:fakestore/home_page.dart';
import 'package:fakestore/sign_in_up/signin_Page.dart';
import 'package:fakestore/widgets/color.dart';

import 'package:fakestore/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignInPage()),
              (route) => false);
    }
  }

  @override
  void initState() {
    Future.delayed(
      Duration(
        seconds: 3
      ),
        ()=>isLogin(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image.asset("images/shop.png",height: 300,width: 300,),

              SizedBox(height: 50,),

              spinkit,
              SizedBox(height: 50,),
              Text("Welcome to Fake Store",style: TextStyle(fontSize: 18,color: fontColor),),
            ],
          ),
        ),
      ),
    );
  }
}
