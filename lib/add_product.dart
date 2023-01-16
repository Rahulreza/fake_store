import 'dart:io';

import 'package:fakestore/auth/custom_http.dart';
import 'package:fakestore/widgets/color.dart';
import 'package:fakestore/widgets/common_widgets.dart';
import 'package:fakestore/widgets/customed_button.dart';
import 'package:fakestore/widgets/customed_texfield.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? categoryType;
  TextEditingController nameController = TextEditingController();
  TextEditingController orginalPriceController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();
  TextEditingController discountTypeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  @override
  void initState() {
    //Provider.of<CategoryProvider>(context, listen: false).getCategoryData();
    super.initState();
  }
  bool isLoading = true;
  uploadProduct() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
      String uriLink = "${baseUrl}products/";
      var request = http.MultipartRequest("POST", Uri.parse(uriLink));
      request.headers.addAll(await CustomHttpRequest.getHeaderWithToken());
      request.fields["name"] = nameController.text.toString();
      request.fields["category_id"] = categoryType.toString();
      request.fields["quantity"] = quantityController.text.toString();
      request.fields["original_price"] = orginalPriceController.text.toString();
      request.fields["discounted_price"] =
          discountPriceController.text.toString();
      request.fields["discount_type"] = "fixed";
      var photo = await http.MultipartFile.fromPath("image",image!.path);
      request.files.add(photo);
      var responce = await request.send();
      var responceData = await responce.stream.toBytes();
      var responceString = String.fromCharCodes(responceData);
      print("responce bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy ${responceString}");
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
  //List<CategoryModel> categoryList = [];
  @override
  Widget build(BuildContext context) {
    //categoryList = Provider.of<CategoryProvider>(context).categoryList;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: dialogBGColor,
          leading:  IconButton(
            icon: Icon(Icons.arrow_back, size: 25,),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Add Product',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,

        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Stack(
                      //overflow: Overflow.visible,
                      children: [
                        Container(
                          height: 150,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
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
                          left: MediaQuery.of(context).size.width * 0.4,
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
                    CustomTextField(
                      Controller: nameController,
                      labelText: "Enter product Name",
                      icon: Icons.abc,
                    ),
                    CustomTextField(
                      Controller: orginalPriceController,
                      labelText: "Enter product Price",
                      icon: Icons.price_change,
                    ),
                    CustomTextField(
                      Controller: discountPriceController,
                      labelText: "Enter Discount Price",
                      icon: Icons.abc,
                    ),
                    CustomTextField(
                      Controller: quantityController,
                      labelText: "Enter Quantity",
                      icon: Icons.abc,
                    ),
                    customButton("Add Product", () {
                      uploadProduct();
                    })
                  ],
                ),
              )),
        ),
      ),
    );
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
}
