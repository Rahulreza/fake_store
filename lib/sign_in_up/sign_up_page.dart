import 'package:fakestore/profile/user_profile.dart';
import 'package:fakestore/sign_in_up/signin_Page.dart';
import 'package:fakestore/widgets/color.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fakestore/widgets/common_widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _avatorController = TextEditingController();
  final GlobalKey<FormState> _fromkey = GlobalKey();
  bool isObsecure = true;

  getSignUp() async {
    try {
      setState(() {
        isLoading = true;
      });
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      String link = "${baseUrl}users/";
      var map = Map<String, dynamic>();
      map["name"] = _nameController.text.toString();
      map["email"] = _emailController.text.toString();
      map["password"] = _passwordController.text.toString();
      map["avatar"] = _avatorController.text.toString();
      var responce = await http.post(Uri.parse(link), body: map);
      var data = jsonDecode(responce.body);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignInPage()));
      // print("access token is ${data["access_token"]}");
      // if (data["access_token"] != null) {
      //   sharedPreferences.setString("token", data["access_token"]);
      //   print("saved token is ${sharedPreferences.getString("token")}");
      //   Navigator.of(context).pushAndRemoveUntil(
      //       MaterialPageRoute(builder: (context) => SignInPage()),
      //           (route) => false);
      // } else {
      //
      // }
    } catch (e) {
      print(e);
    }
  }

  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _avatorController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall: isLoading == true,
      blur: 0.5,
      opacity: 0.5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: dialogBGColor,
          leading: Icon(Icons.menu,size: 25,),
          title: Text(
            'Login',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              iconSize: 25,
              icon:  Icon(
                Icons.person,
              ),
              onPressed: () {
                setState(
                      () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserProfilePage()));
                  },
                );
              },
            ),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(),
            child: Padding(
              padding: EdgeInsets.only(top: 100, left: 15, right: 15),
              child: Form(
                key: _fromkey,
                child: ListView(
                  children: [
                    //Center(child: Text("Login", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),)),
                    SizedBox(
                      height: 50,
                    ),
                    TextField(
                      style: TextStyle(
                          color: fontColor
                      ),
                      controller: _nameController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff7B81EC),
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff7B81EC),
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: "Name",
                        suffixIcon: Icon(
                          Icons.drive_file_rename_outline,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    TextField(
                      style: TextStyle(
                          color: fontColor
                      ),
                      controller: _emailController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff7B81EC),
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff7B81EC),
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: "Email",
                        suffixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: TextStyle(
                          color: fontColor
                      ),
                      controller: _passwordController,
                      obscureText: isObsecure,
                      obscuringCharacter: "•",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff7B81EC),
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff7B81EC),
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObsecure = !isObsecure;
                            });
                          },
                          icon: Icon(
                            isObsecure == true
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: TextStyle(
                          color: fontColor
                      ),
                      controller: _avatorController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff7B81EC),
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff7B81EC),
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: "Avator Link",
                        suffixIcon: Icon(
                          Icons.person,
                          color: Colors.black54,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    InkWell(
                      onTap: () {
                        if (_fromkey.currentState!.validate()) {
                          getSignUp();
                        } else {
                          showInToast("Enter all fields");
                        }
                      },
                      child: Container(
                        height: 55,
                        child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            )),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xff5660CD),
                            Color(0xff7B81EC),
                          ]),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),

                    // SizedBox(
                    //   height: 10,
                    // ),
                    //
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "Don't have an account? ",
                    //       style: TextStyle(
                    //           color: Colors.grey,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w400),
                    //     ),
                    //     TextButton(
                    //       onPressed: () {},
                    //       child: Text(
                    //         "Sign Up",
                    //         style: TextStyle(
                    //             color: Color(0xff7B81EC),
                    //             fontSize: 20,
                    //             fontWeight: FontWeight.w700),
                    //       ),
                    //     )
                    //   ],
                    // )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
