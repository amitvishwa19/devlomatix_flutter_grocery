import 'dart:convert';
import 'package:devlomatix/models/productModel.dart';
import 'package:http/http.dart' as http;

import 'package:devlomatix/models/cartModel.dart';
import 'package:devlomatix/utils/api.dart';
import 'package:devlomatix/utils/pref.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cartItems = [];
  List<ProductModel> products = [];

  int totalPrice = 0;
  int totalDiscount = 0;
  int totalTax = 0;
  int netPrice = 0;
  int deliveryCharge = 0;

  int cartCount = 0;

  CartProvider() {}

  getCartData() async {
    final String _url = API.cart.toString();
    String _token = await SharePref.getString('token');
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    final response = await http.get(Uri.parse(_url), headers: header);

    print('getCartData function is called');
    if (response.statusCode == 200) {
      cartItems = (json.decode(response.body) as List)
          .map((i) => CartModel.fromJson(i))
          .toList();
      notifyListeners();
      await cartSummary();
    }
  }

  cartSummary() {
    int tPrice = 0;
    int nPrice = 0;

    for (var element in cartItems) {
      tPrice += (element.product!.price ?? 0) * (element.quantity ?? 0);
      nPrice += (element.product!.netPrice ?? 0) * (element.quantity ?? 0);
      totalDiscount = tPrice - nPrice;

      totalPrice = tPrice;
      netPrice = nPrice;
    }
    notifyListeners();
  }

  addToCart(itemId, quantity) async {
    final String _url = API.addToCart.toString();

    String _token = await SharePref.getString('token');

    var data = jsonEncode({'productId': itemId, 'quantity': quantity});

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    final response =
        await http.post(Uri.parse(_url), body: data, headers: header);

    if (response.statusCode == 200 || response.statusCode == 201) {
      await getCartData();
      await cartSummary();
    }
  }

  deleteCartItem(id) async {
    final String _url = API.deleteFromCart.toString();

    String _token = await SharePref.getString('token');

    var data = jsonEncode({'cartId': id});

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    final response =
        await http.post(Uri.parse(_url), body: data, headers: header);

    if (response.statusCode == 200 || response.statusCode == 201) {
      cartItems.removeWhere((item) => item.cartId == id);
      await getCartData();
      await cartSummary();
    }
  }

  updateCart(add, id) async {
    final String _url = API.updateCart.toString();

    String _token = await SharePref.getString('token');

    var data = jsonEncode({'add': add, 'cartId': id});

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    final response =
        await http.post(Uri.parse(_url), body: data, headers: header);

    if (response.statusCode == 200) {
      await getCartData();
      await cartSummary();
    }
  }
}
