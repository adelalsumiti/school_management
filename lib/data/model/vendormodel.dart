// ignore_for_file: file_names

import 'package:school_management/data/model/accountsmodel.dart';

class VendorModel {
  dynamic id;
  dynamic accid;
  dynamic name;
  dynamic email;
  dynamic shop;
  dynamic address;
  dynamic phone;
  dynamic type;
  dynamic father;
  dynamic date;
  AccountsModel? accountsModel;
  dynamic userid;

  VendorModel(
      {this.id,
      this.accid,
      this.name,
      this.shop,
      this.address,
      this.email,
      this.phone,
      this.type,
      this.father,
      this.date,
      this.accountsModel,
      this.userid});

  VendorModel.fromJson(Map<String, dynamic> map) {
    id = map['id'].toString();
    accid = map['acc_id'].toString();
    name = map['name'];
    shop = map['shop'];
    address = map['address'];
    email = map['email'];
    phone = map['phone'].toString();
    type = "${map['type'] ?? 2}";
    date = map["date"];
    userid = map['usr_id'];
    if (map['account'] != null) {
      accountsModel = AccountsModel.fromJson(map['account']);
    }
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "shop": shop,
      "address": address,
      "email": email,
      "phone": phone.toString(),
      "type": type.toString(),
      "usr_id": userid.toString()
    };
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "name": name,
      "shop": shop,
      "address": address,
      "email": email,
      "phone": phone.toString(),
      "father": father.toString(),
      "userid": userid.toString()
    };
  }

  Map<String, dynamic> toJsonEdit() {
    return {
      "id": id.toString(),
      "accid": accid.toString(),
      "name": name,
      "shop": shop,
      "address": address,
      "email": email,
      "phone": phone.toString(),
      "userid": userid.toString()
    };
  }
}
