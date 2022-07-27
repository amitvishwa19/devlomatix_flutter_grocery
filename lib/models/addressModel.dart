class AddressModel {
  int? id;
  String? house;
  String? locality;
  String? landmark;
  String? optional;
  String? city;
  String? state;
  int? pincode;
  int? mobile;
  String? type;
  int? selected;

  AddressModel(
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

  AddressModel.fromJson(Map<String, dynamic> json) {
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
