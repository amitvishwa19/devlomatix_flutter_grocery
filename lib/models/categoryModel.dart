import 'dart:convert';

class CategoryModel {
  String? title;
  String? slug;
  String? image;
  int? featured;

  List<CategoryModel> categoryModelFromJson(String str) =>
      List<CategoryModel>.from(
          json.decode(str).map((x) => CategoryModel.fromJson(x)));

  String categoryModelToJson(List<CategoryModel> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  CategoryModel({this.title, this.slug, this.image, this.featured});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    image = json['image'];
    featured = json['featured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['featured'] = this.featured;
    return data;
  }
}
