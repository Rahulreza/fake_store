import 'package:fakestore/home_page.dart';
import 'package:fakestore/profile/user_profile.dart';
import 'package:fakestore/sign_in_up/signin_Page.dart';
import 'package:fakestore/widgets/color.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fakestore/widgets/common_widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddNewProductPage extends StatefulWidget {
  const AddNewProductPage({Key? key}) : super(key: key);

  @override
  State<AddNewProductPage> createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<AddNewProductPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _categoryIdController = TextEditingController();
  TextEditingController _imagesController = TextEditingController();
  final GlobalKey<FormState> _fromkey = GlobalKey();
  bool isObsecure = true;

  getAddProductPage() async {
    try {
      setState(() {
        isLoading = true;
      });
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      String link = "${baseUrl}products/";
      var map = Map<String, dynamic>();
      map["title"] = _titleController.text.toString();
      map["price"] = _priceController.text.toString();
      map["description"] = _descriptionController.text.toString();
      map["categoryId"] = _categoryIdController.text.toString();
      map["images"] = _imagesController.text.toString();
      var responce = await http.post(Uri.parse(link), body: map);
      var data = jsonDecode(responce.body);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
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
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _categoryIdController.dispose();
    _imagesController.dispose();

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
                      height: 10,
                    ),
                    TextField(
                      style: TextStyle(
                          color: fontColor
                      ),
                      controller: _titleController,
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
                        hintText: "Title",
                        hintStyle: TextStyle(fontSize: 16.0, color:fontColor),
                        suffixIcon: Icon(
                          Icons.title,
                          color: fontColor,
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
                      controller: _priceController,
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
                        hintText: "Price",
                        hintStyle: TextStyle(fontSize: 16.0, color:fontColor),
                        suffixIcon: Icon(
                          Icons.price_check,
                          color: fontColor,
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
                      controller: _descriptionController,
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
                        hintText: "Description",
                        hintStyle: TextStyle(fontSize: 16.0, color:fontColor),
                        suffixIcon: Icon(
                          Icons.description,
                          color: fontColor,
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
                      controller: _categoryIdController,
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
                        hintText: "Category",
                        hintStyle: TextStyle(fontSize: 16.0, color:fontColor),
                        suffixIcon: Icon(
                          Icons.category,
                          color: fontColor,
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
                      controller: _imagesController,
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
                        hintText: "Image Link",
                        hintStyle: TextStyle(fontSize: 16.0, color:fontColor),
                        suffixIcon: Icon(
                          Icons.image,
                          color: fontColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),


                    InkWell(
                      onTap: () {
                        if (_fromkey.currentState!.validate()) {
                          getAddProductPage();
                        } else {
                          showInToast("Enter all fields");
                        }
                      },
                      child: Container(
                        height: 55,
                        child: Center(
                            child: Text(
                              "Upload Product",
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
