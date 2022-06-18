import 'dart:convert';

import 'package:flutter/material.dart';

class ProductModel {
  int? id;
  String? title;
  String? slug;
  String? description;
  String? image;
  String? price;
  int? discount;
  String? netPrice;
  String? sku;
  int? featured;
  int? rating;

  List<ProductModel> productModelFromJson(String str) =>
      List<ProductModel>.from(
          json.decode(str).map((x) => ProductModel.fromJson(x)));

  String productModelToJson(List<ProductModel> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  ProductModel(
      {this.id,
      this.title,
      this.slug,
      this.description,
      this.image,
      this.price,
      this.discount,
      this.netPrice,
      this.sku,
      this.featured,
      this.rating});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    discount = json['discount'];
    netPrice = json['netPrice'];
    sku = json['sku'];
    featured = json['featured'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['netPrice'] = this.netPrice;
    data['sku'] = this.sku;
    data['featured'] = this.featured;
    data['rating'] = this.rating;
    return data;
  }
}
