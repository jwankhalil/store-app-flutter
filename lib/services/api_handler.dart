import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:store_app/constants/api_consts.dart';
import 'package:store_app/models/category_model.dart';
import 'package:store_app/models/products_model.dart';
import 'package:store_app/models/user_model.dart';

class ApiHandler {
static Future<List<dynamic>> getData({required String target ,String? limit}) async {
    try {
      var uri = Uri.https(
        BASE_URL,
        "api/v1/$target",
        target == "products"?{
          "offset":"0",
          "limit":limit
        }:{}
      );
      var response = await http.get(uri);
      //print('Response : ${jsonDecode(response.body)}');
      var data = jsonDecode(response.body);
      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data) {
        tempList.add(v);
      }
      return tempList;
    } catch (error) {
      log('An error ocurred$error');
      throw error.toString();
    }
  }

  static Future<List<ProductsModel>> getAllProduct({required String limit}) async {
    List temp = await getData(target: "products",limit: limit);
    return ProductsModel().productsFromJson(temp);
  }

  static Future<List<Categories>> getAllCategories() async {
    List temp = await getData(target: "categories");
    return Categories().categoriesFromJson(temp);
  }

  static Future<List<UsersModel>> getAllUsers() async {
    List temp = await getData(target: "users");
    return UsersModel().userFromJson(temp);
  }

  static Future<ProductsModel> getProdutById(String id) async {
    try {
      var uri = Uri.https(BASE_URL, "api/v1/products/$id");
      var response = await http.get(uri);

      //print('Response : ${jsonDecode(response.body)}');
      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw data["message"];
      }

      return ProductsModel.fromJson(data);
    } catch (error) {
      log("An error occurred while getting product info$error");
      throw error.toString();
    }
  }
   static Future<List<ProductsModel>> getProdutByCategry(String id) async {
    try {
      var uri = Uri.https(BASE_URL, "api/v1/categories/$id/products");
      var response = await http.get(uri);

      //print('Response : ${jsonDecode(response.body)}');
        var data = jsonDecode(response.body);
      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data) {
        tempList.add(v);
      }
      if (response.statusCode != 200) {
        throw data["message"];
      }

      return ProductsModel().productsFromJson(tempList);
    } catch (error) {
      log("An error occurred while getting product info$error");
      throw error.toString();
    }
  }
}
