

import 'package:flutter/cupertino.dart';

class Categories with ChangeNotifier {
  int? id;
  String? name;
  String? image;

  Categories({this.id, this.name, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
  List<Categories> categoriesFromJson(List category){
    return category.map((data) {
    // print('data $data');
      return Categories.fromJson(data);
      
    }).toList();
  }

}
