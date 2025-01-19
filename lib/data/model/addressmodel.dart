class AddressModel {
  dynamic addrssid;
  dynamic name;
  dynamic city;
  dynamic street;
  dynamic lat;
  dynamic lang;
  dynamic usersid;

  AddressModel(
      {required this.addrssid,
      required this.name,
      required this.city,
      required this.street,
      required this.lat,
      required this.lang,
      required this.usersid});

  AddressModel.fromJson(Map<String, dynamic> json) {
    addrssid = json['address_id'].toString();
    name = json['address_name'];
    city = json['address_city'];
    street = json['address_street'];
    lat = json['address_lat'].toString();
    lang = json['address_elang'].toString();
    usersid = json['address_usersid'].toString();
  }
}
