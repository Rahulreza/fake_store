class CategoryModel {
  String? title;
  int? price;
  String? description;
  String? categoryId;
  String? images;

  CategoryModel({this.title,this.price, this.description, this.categoryId, this.images});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    description = json['description'];
    categoryId = json['categoryId'];
    images = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['categoryId'] = this.categoryId;
    data['images'] = this.images;
    return data;
  }
}