import 'package:devlomatix/models/loginModel.dart';
import 'package:devlomatix/utils/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  Future<LoginModel> login(data) async {
    LoginModel loginModel = LoginModel();
    print('AuthService Login Method');
    final String url = API.loginUrl.toString();

    final response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      final String res = response.body;
      loginModel = LoginModel.fromJson(json.decode(res));
    } else {
      //throw Exception('Failed to load data or Invalid Credentials');
      return loginModel;
    }

    return loginModel;
  }

  Future<LoginModel> register(data) async {
    LoginModel loginModel = LoginModel();

    final String url = API.registerUrl.toString();
    final response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      final String res = response.body;
      loginModel = LoginModel.fromJson(json.decode(res));
    } else {
      //throw Exception('Failed to load data or Invalid Credentials');
      return loginModel;
    }

    return loginModel;
  }
}
