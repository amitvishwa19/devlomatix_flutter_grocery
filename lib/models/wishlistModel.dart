import 'dart:convert';

class WishlistModel {
  int? id;
  int? userId;
  Product? product;

  List<WishlistModel> wishlistModelFromJson(String str) =>
      List<WishlistModel>.from(
          json.decode(str).map((x) => WishlistModel.fromJson(x)));

  String wishlistModelToJson(List<WishlistModel> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  WishlistModel({this.id, this.userId, this.product});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? title;
  String? slug;
  String? description;
  String? image;
  int? price;
  int? discount;
  int? netPrice;
  String? sku;
  int? featured;
  int? rating;
  int? quantity;

  Product(
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
      this.rating,
      this.quantity});

  Product.fromJson(Map<String, dynamic> json) {
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
    quantity = json['quantity'];
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
    data['quantity'] = this.quantity;
    return data;
  }
}
