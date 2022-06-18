import 'package:flutter/material.dart';

class UserModel {
  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? avatar;
  String? type;
  String? role;

  UserModel(
      {this.firstname,
      this.lastname,
      this.username,
      this.email,
      this.avatar,
      this.type,
      this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    username = json['username'];
    email = json['email'];
    avatar = json['avatar'];
    type = json['type'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = firstname ?? '';
    data['lastname'] = lastname ?? '';
    data['username'] = username ?? '';
    data['email'] = email;
    data['avatar'] = avatar;
    data['type'] = type;
    data['role'] = role;
    return data;
  }
}
