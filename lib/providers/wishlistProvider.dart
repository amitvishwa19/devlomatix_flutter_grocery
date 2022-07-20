import 'dart:convert';

import 'package:devlomatix/models/productModel.dart';
import 'package:devlomatix/models/wishlistModel.dart';
import 'package:devlomatix/utils/api.dart';
import 'package:devlomatix/utils/pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class WishlistProvider extends ChangeNotifier {
  List<WishlistModel> wishlist = [];

  Future addToWishList(id) async {
    final String _url = API.addToWishlist.toString();

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
      await getWishList();
    }
  }

  Future removeFromWishList(id) async {
    final String _url = API.removeFrmWishlist.toString();

    String _token = await SharePref.getString('token');
    var data = jsonEncode({'id': id});

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    final response =
        await http.post(Uri.parse(_url), body: data, headers: header);
    print(response.statusCode);
    if (response.statusCode == 200) {
      wishlist.removeWhere((item) => item.id == id);
      //await getWishList();
    }

    notifyListeners();
  }

  Future getWishList() async {
    final String _url = API.getWishlist.toString();

    String _token = await SharePref.getString('token');

    //var data = jsonEncode({'productId': id});

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    final response = await http.get(Uri.parse(_url), headers: header);

    if (response.statusCode == 200) {
      wishlist = (json.decode(response.body) as List)
          .map((i) => WishlistModel.fromJson(i))
          .toList();
      notifyListeners();
    }
  }
}
