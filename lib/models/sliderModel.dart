import 'dart:convert';

class SliderModel {
  String? title;
  String? slug;
  String? description;
  String? image;
  int? featured;

  List<SliderModel> sliderModelFromJson(String str) => List<SliderModel>.from(
      json.decode(str).map((x) => SliderModel.fromJson(x)));

  String sliderModelToJson(List<SliderModel> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  SliderModel(
      {this.title, this.slug, this.description, this.image, this.featured});

  SliderModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    image = json['image'];
    featured = json['featured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['image'] = this.image;
    data['featured'] = this.featured;
    return data;
  }
}
