import 'dart:convert';

List<CartModel> cartModelFromJson(String str) =>
    List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
  int? cartId;
  Product? product;
  int? quantity;

  CartModel({this.cartId, this.product, this.quantity});

  CartModel.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
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
      this.rating});

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
