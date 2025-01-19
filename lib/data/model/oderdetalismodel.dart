import 'package:school_management/data/model/addressmodel.dart';
import 'package:school_management/data/model/colormodel.dart';
import 'package:school_management/data/model/usersmodel.dart';

class OrderModel {
  dynamic orderid;
  dynamic addressid;
  dynamic type;
  dynamic status;
  dynamic paymentmethod;
  dynamic useracceptid;
  dynamic usercstmrid;
  dynamic date;
  dynamic totalprice;
  dynamic accid;
  dynamic accname;
  dynamic username;
  dynamic email;
  dynamic shop;
  dynamic address;
  dynamic phone;
  dynamic image;
  dynamic qtyItems;
  List<OrderDetailsModel>? listDetails;
  AddressModel? addressModel;
  UsersModel? usersModel;

  OrderModel({
    this.orderid,
    this.addressid,
    this.type,
    this.status,
    this.paymentmethod,
    this.useracceptid,
    this.usercstmrid,
    this.date,
    this.totalprice,
    this.listDetails,
    this.addressModel,
    this.usersModel,
    this.accid,
    this.accname,
    this.address,
    this.email,
    this.image,
    this.phone,
    this.qtyItems,
    this.shop,
    this.username,
  });
// cart_itemdiscount
  OrderModel.fromJson(Map<String, dynamic> json) {
    orderid = json['id'].toString();
    addressid = json['address_id'].toString();
    type = json['type'].toString();
    status = json['status'].toString();
    paymentmethod = json['paymentmethod'].toString();
    useracceptid =
        json['usr_accept_id'] != null ? json['usr_accept_id'].toString() : "0";
    usercstmrid = json['usr_cstmr_id'].toString();
    date = json['date'];
    double totl = double.parse(
        json["totalprice"] != null ? json["totalprice"].toString() : "0");
    totalprice = totl.toStringAsFixed(3).toString();
    accid = json["acc_id"].toString();
    accname = json["acc_name"];
    username = json["usr_name"];
    email = json["email"];
    shop = json["shop"];
    address = json["address"];
    phone = json["phone"];
    image = json["image"];
    qtyItems = json["qtyitems"];
    // addressModel =
    //     json['address'] != null ? AddressModel.fromJson(json["address"]) : null;
    // usersModel =
    //     json['user'] != null ? UsersModel.fromJson(json["user"]) : UsersModel();
    // if (json['orderdetails'] != null) {
    //   listDetails = [];
    //   json["orderdetails"].forEach((v) {
    //     listDetails!.add(OrderDetailsModel.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderid'] = orderid;
    data['address_id'] = addressid;
    data['type'] = type;
    data['status'] = status;
    data['paymentmethod'] = paymentmethod;
    data['usr_accept_id'] = useracceptid;
    data['usr_cstmr_id'] = usercstmrid;
    return data;
  }
}

class OrderDetailsModel {
  dynamic orderdtailsId;
  dynamic orderId;
  dynamic cartId;
  dynamic itemId;
  dynamic itemName;
  // dynamic itemNamear;
  dynamic itemDescr;
  // dynamic itemDescrAr;
  dynamic itemImage;
  dynamic userId;
  dynamic status;
  dynamic date;
  dynamic countcolor;
  dynamic countsize;
  dynamic totalprice;
  List<ColorModel>? colors;

  OrderDetailsModel(
      {this.orderdtailsId,
      this.orderId,
      this.cartId,
      this.itemId,
      this.itemName,
      // this.itemNamear,
      this.itemDescr,
      // this.itemDescrAr,
      this.itemImage,
      this.userId,
      this.status,
      this.date,
      this.countcolor,
      this.countsize,
      this.totalprice,
      this.colors});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    orderdtailsId = json['orderdtails_id'];
    orderId = json['order_id'];
    cartId = json['cart_id'];
    itemId = json['itm_id'];
    itemName = json['itm_name'];
    // itemNamear = json['itm_namear'];
    itemDescr = json['itm_descr'];
    // itemDescrAr = json['itm_descr_ar'];
    itemImage = json['itm_image'];
    userId = json['usr_id'];
    status = json['status'];
    date = json['date'];
    countcolor = json['countcolor'];
    countsize = json['countsize'];
    totalprice = json['totalprice'];
    if (json['colors'] != null) {
      colors = <ColorModel>[];
      json['colors'].forEach((v) {
        colors!.add(ColorModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderdtails_id'] = orderdtailsId;
    data['order_id'] = orderId;
    data['cart_id'] = cartId;
    data['itm_id'] = itemId;
    data['itm_name'] = itemName;
    // data['itm_namear'] = itemNamear;
    data['itm_descr'] = itemDescr;
    // data['itm_descr_ar'] = itemDescrAr;
    data['itm_image'] = itemImage;
    data['usr_id'] = userId;
    data['status'] = status;
    data['date'] = date;
    data['countcolor'] = countcolor;
    data['countsize'] = countsize;
    data['totalprice'] = totalprice;

    return data;
  }
}
