import 'dart:convert';

import 'package:devlomatix/models/addressModel.dart';
import 'package:devlomatix/models/orderModel.dart';
import 'package:devlomatix/utils/api.dart';
import 'package:devlomatix/utils/pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CheckoutProvider extends ChangeNotifier {
  List<AddressModel> addresses = [];
  List<AddressModel> allAddresses = [];
  List<OrderModel> orders = [];
  AddressModel deliveryAddress = AddressModel();

  Future<void> getAddress() async {
    List<AddressModel> add = [];

    final String url = API.getAddress.toString();

    String token = await SharePref.getString('token');

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      addresses = (json.decode(response.body) as List)
          .map((i) => AddressModel.fromJson(i))
          .toList();

      notifyListeners();
    }
  }

  Future addAddress(data) async {
    final String url = API.addAddress.toString();

    String token = await SharePref.getString('token');

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(Uri.parse(url),
        body: jsonEncode(data), headers: header);
    var jsonRes = jsonDecode(response.body);

    print(response.statusCode);
    print(response.statusCode);

    if (response.statusCode == 200) {
      await getAddress();
      return jsonRes['message'];
    }
  }

  Future<void> deleteAddress(id) async {
    final String url = API.deleteAddress.toString();
    String token = await SharePref.getString('token');
    var data = jsonEncode({'id': id});
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response =
        await http.post(Uri.parse(url), body: data, headers: header);
    print(response.statusCode);
    if (response.statusCode == 200) {
      await getAddress();
    }
  }

  Future checkout(order) async {
    final String url = API.newOrder.toString();
    String token = await SharePref.getString('token');
    var data = jsonEncode(order);

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response =
        await http.post(Uri.parse(url), body: data, headers: header);

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      return res['message'];
    } else {
      print('Error while fetching data');
    }
  }

  Future allOrders() async {
    print('All orders is called');
    final String url = API.allOrders.toString();
    String token = await SharePref.getString('token');

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      orders = (json.decode(response.body) as List)
          .map((i) => OrderModel.fromJson(i))
          .toList();
      notifyListeners();
    }
  }

  Future cancelOrder(id) async {
    final String url = API.cancelOrder.toString();
    String token = await SharePref.getString('token');
    var data = jsonEncode({'id': id});

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response =
        await http.post(Uri.parse(url), body: data, headers: header);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var res = jsonDecode(response.body);
      return res['message'];
    }
  }

  Future orderAgain(id) async {
    final String url = API.cloneOrder.toString();
    String token = await SharePref.getString('token');
    var data = jsonEncode({'id': id});

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response =
        await http.post(Uri.parse(url), body: data, headers: header);

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      return res['message'];
    }
  }
}
