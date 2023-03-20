class AddressModel {
  String? city;
  String? state;
  String? country;
  String? postalcode;
  double? lat;
  double? lng;
  String? status;

  AddressModel(
      {this.city,
      this.state,
      this.country,
      this.postalcode,
      this.lat,
      this.lng,
      this.status});

  AddressModel.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postalcode = json['postalcode'];
    lat = json['lat'];
    lng = json['lng'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['postalcode'] = postalcode;
    data['lat'] = lat;
    data['lng'] = lng;
    data['status'] = status;
    return data;
  }
}
