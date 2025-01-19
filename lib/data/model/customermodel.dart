// ignore_for_file: file_names

import 'package:school_management/data/model/accountsmodel.dart';

class CustomerModel {
  dynamic id;
  dynamic accid;
  dynamic name;
  dynamic email;
  dynamic shop;
  dynamic address;
  dynamic phone;
  dynamic password;
  dynamic newPassword;
  dynamic image;
  // type user if 0 signup customer if 1 admin if 2 customer if 3 signup admin if 4 stop
  dynamic typeuser;
  dynamic father;
  dynamic date;
  AccountsModel? accountsModel;
  dynamic userid;

  CustomerModel(
      {this.id,
      this.accid,
      this.name,
      this.shop,
      this.address,
      this.email,
      this.phone,
      this.password,
      this.newPassword,
      this.image,
      this.typeuser,
      this.father,
      this.date,
      this.accountsModel,
      this.userid});

  CustomerModel.fromJson(Map<String, dynamic> map) {
    id = map['id'].toString();
    accid = map['acc_id'].toString();
    name = map['name'];
    shop = map['shop'];
    address = map['address'];
    email = map['email'];
    phone = map['phone'];
    image = map['image'];
    password = map['password'];
    typeuser = "${map['type'] ?? 2}";
    date = map["date"];
    userid = map['usr_id'].toString();
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
      "type": typeuser.toString(),
      "usr_id": userid.toString()
    };
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "name": name,
      "shop": shop,
      "address": address,
      "email": email,
      "phone": phone,
      "father": father.toString(),
      "userid": userid.toString(),
      "type": typeuser.toString(),
      "password": password
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
      "type": typeuser.toString(),
      "userid": userid.toString()
    };
  }
}
