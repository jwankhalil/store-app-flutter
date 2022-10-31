import 'package:flutter/foundation.dart';
import 'package:store_app/models/category_model.dart';

class ProductsModel with ChangeNotifier {
  int? id;
  String? title;
  int? price;
  String? description;
  Categories? category;
  List<String>? images;

  ProductsModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.images});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? new Categories.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
  }
  List<ProductsModel> productsFromJson(List products){
    return products.map((data) {
    // print('data $data');
      return ProductsModel.fromJson(data);
    }).toList();
  }
}
