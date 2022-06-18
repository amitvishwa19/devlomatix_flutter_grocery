import 'dart:convert';

import 'package:devlomatix/models/categoryModel.dart';
import 'package:devlomatix/models/productModel.dart';
import 'package:devlomatix/models/sliderModel.dart';
import 'package:devlomatix/utils/api.dart';
import 'package:devlomatix/utils/pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  List<SliderModel> slider = [];
  List<CategoryModel> category = [];
  List<ProductModel> trending = [];
  List<ProductModel> hotProd = [];
  ProductModel product = ProductModel();
  int cartCount = 0;
  bool favrouite = false;

  Future<void> getSlider() async {
    final String url = API.grocerySlider.toString();

    String token = await SharePref.getString('token');

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      slider = (json.decode(response.body) as List)
          .map((i) => SliderModel.fromJson(i))
          .toList();
      notifyListeners();
    }
  }

  Future<void> getCategory() async {
    final String url = API.groceryCategory.toString();

    print(url);

    String token = await SharePref.getString('token');

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      category = (json.decode(response.body) as List)
          .map((i) => CategoryModel.fromJson(i))
          .toList();

      notifyListeners();
    }
  }

  Future<void> hotProducts() async {
    final String url = API.hotProducts.toString();

    String token = await SharePref.getString('token');

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      hotProd = (json.decode(response.body) as List)
          .map((i) => ProductModel.fromJson(i))
          .toList();
      print('hot products:' + hotProd.length.toString());
      notifyListeners();
    }
  }

  Future<void> products(String category) async {
    final String url = API.products.toString() + category;

    String token = await SharePref.getString('token');

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      trending = (json.decode(response.body) as List)
          .map((i) => ProductModel.fromJson(i))
          .toList();
      print('trending products:' + trending.length.toString());
      notifyListeners();
    }

    print('-----------------------product list---------------${url}');
  }

  void isFavorite() {
    favrouite != favrouite;
    notifyListeners();
  }

  void addToCart(ProductModel product) {
    cartCount = cartCount + 1;
    print('Provider : ${product.title} added to Cart');
    notifyListeners();
  }

  void addToWishList(ProductModel product) {
    print('${product.title} added to wishlist');
  }
}
