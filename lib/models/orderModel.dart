class OrderModel {
  int? id;
  List<Cart>? cart;
  Address? address;
  String? status;
  String? paymentId;
  String? date;

  OrderModel(
      {this.id,
      this.cart,
      this.address,
      this.status,
      this.paymentId,
      this.date});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    status = json['status'];
    paymentId = json['payment_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['status'] = this.status;
    data['payment_id'] = this.paymentId;
    data['date'] = this.date;
    return data;
  }
}

class Cart {
  int? cartId;
  Product? product;
  int? quantity;

  Cart({this.cartId, this.product, this.quantity});

  Cart.fromJson(Map<String, dynamic> json) {
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

class Address {
  int? id;
  String? house;
  String? locality;
  String? landmark;
  Null? optional;
  String? city;
  String? state;
  int? pincode;
  int? mobile;
  String? type;
  int? selected;

  Address(
      {this.id,
      this.house,
      this.locality,
      this.landmark,
      this.optional,
      this.city,
      this.state,
      this.pincode,
      this.mobile,
      this.type,
      this.selected});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    house = json['house'];
    locality = json['locality'];
    landmark = json['landmark'];
    optional = json['optional'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    mobile = json['mobile'];
    type = json['type'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['house'] = this.house;
    data['locality'] = this.locality;
    data['landmark'] = this.landmark;
    data['optional'] = this.optional;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['mobile'] = this.mobile;
    data['type'] = this.type;
    data['selected'] = this.selected;
    return data;
  }
}
