import 'dart:convert';
import 'dart:io';

import 'package:devlomatix/models/userModel.dart';
import 'package:devlomatix/utils/api.dart';
import 'package:devlomatix/utils/pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UserProvider extends ChangeNotifier {
  bool loading = false;
  bool clickable = true;
  UserModel user = UserModel();
  String name = '';
  bool error = false;
  String errorMessage = '';
  var image;
  String? avatar;
  final picker = ImagePicker();

  Future<void> getUser(token) async {
    final String _url = API.user.toString();

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(Uri.parse(_url), headers: header);
    var res = jsonDecode(response.body);
    user = UserModel.fromJson(res);
    notifyListeners();
  }

  profilePhoto() {
    if (image == null) {
      if (avatar == null) {
        return null;
      } else {
        return NetworkImage(avatar.toString());
      }
    } else {
      return FileImage(File(image.path));
    }
  }

  Future pickImage(type) async {
    final pickedFile = await picker.pickImage(source: type);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      print(image);
      notifyListeners();
    } else {
      print('No image selected.');
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

    return jsonRes['message'];
  }
}
