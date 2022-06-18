import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:devlomatix/models/loginModel.dart';

import 'package:devlomatix/utils/api.dart';
import 'package:devlomatix/utils/pref.dart';
import 'package:devlomatix/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  bool loading = false;
  bool clickable = true;
  bool loggedIn = false;
  bool onboarding = true;
  String authToken = '';
  String errorMessage = '';

  void startLoad() {
    loading = true;
    clickable = false;
    notifyListeners();
  }

  void stoptLoad() {
    loading = false;
    clickable = true;
    notifyListeners();
  }

  Future<bool> login(String email, String pwd) async {
    final String url = API.loginUrl.toString();
    var data = {'email': email, 'password': pwd};

    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        print('Timeout');
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      var jsonRes = jsonDecode(response.body);

      if (response.statusCode == 200) {
        loggedIn = true;
        authToken = jsonRes['token'];
        await SharePref.setString('token', authToken);
        await SharePref.setBool('loggedIn', true);
        notifyListeners();
        return true;
      } else {
        loggedIn = false;
        authToken = '';
        //errMsg = jsonRes['messege'];
        notifyListeners();
        return false;
      }
    } on TimeoutException catch (_) {
      print('Timeout exception');
      return false;
    }
  }

  Future<String> refresh(String _token) async {
    final String url = API.refreshToken.toString();
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    //print('Auth service refresh method token: $_token');

    try {
      final response = await http
          .get(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 5));
      var jsonRes = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var accessToken = jsonRes['access_token'];
        return accessToken;
      } else {
        return errorMessage = 'unauthenticated.';
      }
    } on TimeoutException catch (_) {
      return errorMessage = 'error';
    } on SocketException {
      return errorMessage = 'error';
    }
  }

  Future<dynamic> appLogin(String email, String pwd) async {
    final String url = API.loginUrl.toString();
    LoginModel loginModel = LoginModel();

    var data = {'email': email, 'password': pwd};

    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 5));
      var jsonRes = jsonDecode(response.body);
      if (response.statusCode == 200) {
        loggedIn = true;
        authToken = jsonRes['token'];
        await SharePref.setString('token', authToken);
        await SharePref.setBool('loggedIn', true);
        notifyListeners();
        return 'Login Success';
        ;
      } else {
        return errorMessage = 'Invalid credentials';
      }
    } on TimeoutException catch (_) {
      return errorMessage = 'Server time out, Please try again later';
    } on SocketException {
      return errorMessage = 'You are not connected to internet';
    }
  }
}
