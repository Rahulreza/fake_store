import 'package:fakestore/auth/custom_http.dart';
import 'package:fakestore/model/category_model.dart';
import 'package:flutter/foundation.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> categoryList = [];

  getCategoryData() async {
    categoryList = await CustomHttpRequest.fetchAllCategory();
    notifyListeners();
  }
}