import 'dart:convert';
import 'package:devlomatix/models/categoryModel.dart';
import 'package:devlomatix/models/productModel.dart';
import 'package:devlomatix/models/sliderModel.dart';
import 'package:devlomatix/utils/api.dart';
import 'package:devlomatix/utils/pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  bool loading = false;
  List<SliderModel> slider = [];
  List<CategoryModel> category = [];
  List<ProductModel> trending = [];
  List<ProductModel> featured = [];
  List<ProductModel> hotProd = [];
  List<ProductModel> allProducts = [];
  List<ProductModel> recentlyViewed = [];
  List<ProductModel> mostViewed = [];
  List<ProductModel> searchDefaultItems = [];
  List<ProductModel> searchedItems = [];

  String categoryProductTitle = '';
  List<ProductModel> categoryProducts = [];

  ProductModel product = ProductModel();
  int cartCount = 0;
  bool favrouite = false;
  String productCategory = '';

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

  // Future<void> getProducts(title, slug) async {
  //   final String url = API.products.toString() + slug;

  //   String token = await SharePref.getString('token');

  //   var header = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };

  //   final response = await http.get(Uri.parse(url), headers: header);
  //   if (response.statusCode == 200) {
  //     allProducts = (json.decode(response.body) as List)
  //         .map((i) => ProductModel.fromJson(i))
  //         .toList();
  //     notifyListeners();
  //   }
  // }

  Future getCategoryProducts(String category) async {
    //categoryProducts = [];
    final String url = API.products.toString() + category;

    String token = await SharePref.getString('token');

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.get(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      categoryProducts = (json.decode(response.body) as List)
          .map((i) => ProductModel.fromJson(i))
          .toList();
      notifyListeners();
      return 'success';
    }
  }

  Future<void> featuredProd() async {
    final String url = API.products.toString() + 'featured';

    String token = await SharePref.getString('token');

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      featured = (json.decode(response.body) as List)
          .map((i) => ProductModel.fromJson(i))
          .toList();
      searchDefaultItems.addAll(featured);
      notifyListeners();
    }
  }

  Future<void> hotProducts() async {
    final String url = API.products.toString() + 'hot';

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
      searchDefaultItems.addAll(hotProd);
      notifyListeners();
    }
  }

  Future<void> trendingProd() async {
    final String url = API.products.toString() + 'trending';

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
      searchDefaultItems.addAll(trending);
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
      notifyListeners();
    }
  }

  Future<void> trendingItems(String category) async {
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
      notifyListeners();
    }
  }

  Future<List<ProductModel>?> productList(String category) async {
    final String url = API.products.toString() + category;
    String _token = await SharePref.getString('token');

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    final response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((i) => ProductModel.fromJson(i))
          .toList();
    } else {
      return null;
    }
  }

  void setProductCategory(String title) {
    productCategory = title.toString();
    notifyListeners();
  }

  void allProductsList() {}

  void addToCart(ProductModel product) {
    cartCount = cartCount + 1;
    print('Provider : ${product.title} added to Cart');
    notifyListeners();
  }

  void markViewed(id) async {
    final String _url = API.viewProduct.toString();

    String _token = await SharePref.getString('token');

    var data = jsonEncode({'productId': id});

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    final response =
        await http.post(Uri.parse(_url), body: data, headers: header);

    if (response.statusCode == 200) {
      await getRecentlyViewed();
      await getMostViewed();
    }
  }

  getRecentlyViewed() async {
    final String _url = API.viewedRecent.toString();

    String _token = await SharePref.getString('token');

    //var data = jsonEncode({'productId': id});

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    final response = await http.get(Uri.parse(_url), headers: header);

    if (response.statusCode == 200) {
      recentlyViewed = (json.decode(response.body) as List)
          .map((i) => ProductModel.fromJson(i))
          .toList();
      notifyListeners();
    }
  }

  getMostViewed() async {
    final String _url = API.mostViewed.toString();

    String _token = await SharePref.getString('token');

    //var data = jsonEncode({'productId': id});

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    final response = await http.get(Uri.parse(_url), headers: header);

    if (response.statusCode == 200) {
      mostViewed = (json.decode(response.body) as List)
          .map((i) => ProductModel.fromJson(i))
          .toList();
      notifyListeners();
    }
  }

  Future<List<ProductModel>> searchItems(String query) async {
    List<ProductModel> items = [];

    final String url = API.productSearch.toString();
    String token = await SharePref.getString('token');
    var data = jsonEncode({'string': query});
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    print(query);
    final response =
        await http.post(Uri.parse(url), body: data, headers: header);

    if (response.statusCode == 200) {
      Iterable i = json.decode(response.body);
      // items = (json.decode(response.body) as List)
      //     .map((i) => ProductModel.fromJson(i))
      //     .toList();
      items = List<ProductModel>.from(i.map((e) => ProductModel.fromJson(e)))
          .toList();

      return items;
    } else {
      return items;
    }
  }

  setDefaultSearchItems() async {
    searchDefaultItems.addAll(featured);
    searchDefaultItems.addAll(trending);
    searchDefaultItems.addAll(hotProd);
    notifyListeners();
  }
}
