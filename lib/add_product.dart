import 'dart:io';

import 'package:fakestore/auth/custom_http.dart';
import 'package:fakestore/model/category_model.dart';
import 'package:fakestore/peovider/category_provider.dart';
import 'package:fakestore/widgets/color.dart';
import 'package:fakestore/widgets/common_widgets.dart';
import 'package:fakestore/widgets/custom_button.dart';
import 'package:fakestore/widgets/customed_button.dart';
import 'package:fakestore/widgets/customed_texfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  //TextForm Variable
  String? categoryID;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();

  bool isLoading = true;
  uploadProduct() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
      String uriLink = "${baseUrl}products/";
      var request = http.MultipartRequest("POST", Uri.parse(uriLink));
      request.headers.addAll(await CustomHttpRequest.getHeaderWithToken());
      request.fields["name"] = _titleController.text.toString();
      request.fields["category_id"] = _priceController.toString();
      request.fields["quantity"] = _descriptionController.text.toString();
      request.fields["categoryId"] = _categoryController.text.toString();
      var photo = await http.MultipartFile.fromPath("image",image!.path);
      request.files.add(photo);
      var responce = await request.send();
      var responceData = await responce.stream.toBytes();
      var responceString = String.fromCharCodes(responceData);
      print("responce body: ${responceString}");
      print(
          "Status code issss${responce.statusCode} ${request.fields} ${request.files.toString()}");
      if (responce.statusCode == 201) {
        showInToast("Product Uploaded Succesfully");

        Navigator.of(context).pop();
      } else {
        showInToast("Something wrong, try again plz bro");
      }
    }
  }
  File? image;
  final picker = ImagePicker();
  bool isImageVisiable = false;

  Future getImageformGallery() async {
    print('on the way of gallery');
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
        print('image found');
        print('${image!.path}');

      } else {
        print('no image found');
      }
    });
  }
  List<CategoryModel> categoryList = [];

  @override
  Widget build(BuildContext context) {
    final weidth = MediaQuery.of(context).size.width;
    return  SafeArea(
      child: Scaffold(
body: Container(
  padding: EdgeInsets.symmetric(horizontal: 20),
  child: SingleChildScrollView(
    child: Column(
      children: [
        SizedBox(height: 20,),
        Stack(
          //overflow: Overflow.visible,
          children: [
            Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: image == null
                  ? InkWell(
                onTap: () {
                  getImageformGallery();
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        color: Colors.teal,
                        size: 40,
                      ),
                      Text(
                        "UPLOAD",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color:
                            Colors.teal.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
              )
                  : Container(
                height: 150,
                width: 200,
                child: Image.file(image!),
              ),
            ),
            Positioned(
              bottom: 0,
              left: weidth * 0.4,
              child: Visibility(
                visible: isImageVisiable,
                child: TextButton(
                  onPressed: () {
                    getImageformGallery();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(50)),
                        color: Colors.black,
                        border: Border.all(
                            color: Colors.black, width: 1.5)),
                    child: Center(
                      child: Container(
                        height: 20,
                        width: 20,
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
        SizedBox(
          height: 20,
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
                color: boxColor,
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
            hintText: "Enter Product Title",
            hintStyle: TextStyle(fontSize: 16.0, color:boxFontColor),
            suffixIcon: Icon(
              Icons.abc,
              color: boxFontColor,
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
                color: boxColor,
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
            hintText: "Enter Product Price",
            hintStyle: TextStyle(fontSize: 16.0, color:boxFontColor),
            suffixIcon: Icon(
              Icons.abc,
              color: boxFontColor,
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
                color: boxColor,
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
            hintText: "Enter Product Details",
            hintStyle: TextStyle(fontSize: 16.0, color:boxFontColor),
            suffixIcon: Icon(
              Icons.abc,
              color: boxFontColor,
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
          controller: _categoryController,
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
                color: boxColor,
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
            hintText: "Enter Category ID",
            hintStyle: TextStyle(fontSize: 16.0, color:boxFontColor),
            suffixIcon: Icon(
              Icons.category_outlined,
              color: boxFontColor,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Custom_Buttom(
          title: "Add Product",isBlue: true,
          onTap: (){
            uploadProduct();
          },
        )
      ],
    ),
  ),
),
      ),
    );
  }
}
