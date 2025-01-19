import 'package:intl/intl.dart';

class InvoiceModel {
  dynamic invId;
  dynamic accId;
  dynamic accSecId;
  dynamic accName;
  dynamic typepay;
  dynamic currId;
  dynamic currName;
  dynamic storeId;
  dynamic storeName;
  dynamic descr;
  dynamic descount;
  dynamic image;
  dynamic usrId;
  dynamic date;
  dynamic dateCre;
  dynamic totalprice;
  dynamic table;
  dynamic tableBills;

  bool? isEdit;
  List<InvoiceBillsModel>? bills;

  InvoiceModel(
      {this.invId,
      this.accId,
      this.accSecId,
      this.accName,
      this.typepay,
      this.currId,
      this.currName,
      this.storeId,
      this.storeName,
      this.descr,
      this.descount,
      this.image,
      this.usrId,
      this.date,
      this.dateCre,
      this.totalprice,
      this.bills,
      this.table,
      this.tableBills,
      this.isEdit});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    invId = json['inv_id'].toString();
    accId = json['acc_id'].toString();
    accName = json['acc_name'];
    accSecId = json['acc_sec_id'];
    typepay = json['typepay'].toString();
    currId = json['curr_id'].toString();
    currName = json['curr_name'];
    storeId = json['store_id'].toString();
    storeName = json['store_name'];
    descr = json['descr'];
    descount = json['descount'].toString();
    image = json['image'];
    usrId = json['usr_id'].toString();
    date = json['date'];
    dateCre = json['date_cre'];
    totalprice = json['totalprice'].toString();
    isEdit = false;
  }
  InvoiceModel.fromJsonWithBills(Map<String, dynamic> json) {
    invId = json['inv_id'].toString();
    accId = json['acc_id'].toString();
    accName = json['acc_name'];
    typepay = json['typepay'].toString();
    currId = json['curr_id'].toString();
    currName = json['curr_name'];
    storeId = json['store_id'].toString();
    storeName = json['store_name'];
    descr = json['descr'];
    descount = json['descount'].toString();
    image = json['image'];
    usrId = json['usr_id'].toString();
    date = json['date'];
    dateCre = json['date_cre'];
    totalprice = json['totalprice'].toString();
    isEdit = false;
    if (json['bills'] != null) {
      bills = <InvoiceBillsModel>[];
      json['bills'].forEach((v) {
        bills!.add(InvoiceBillsModel.fromJson(v));
      });
    }
  }
  InvoiceModel.fromJsonBeginning(Map<String, dynamic> json) {
    invId = json['inv_id'].toString();
    accId = json['acc_id'].toString();
    accName = json['acc_name'];
    typepay = json['typepay'].toString();
    currId = json['curr_id'].toString();
    currName = json['curr_name'];
    storeId = json['store_id'].toString();
    storeName = json['store_name'];
    descr = json['descr'];
    descount = json['descount'].toString();
    image = json['image'];
    usrId = json['usr_id'].toString();
    date = json['date'];
    dateCre = json['date_cre'];
    totalprice = json['totalprice'].toString();
    isEdit = false;
    if (json['bills'] != null) {
      bills = <InvoiceBillsModel>[];
      json['bills'].forEach((v) {
        bills!.add(InvoiceBillsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inv_id'] = invId;
    data['acc_id'] = accId;
    data['acc_name'] = accName;
    data['typepay'] = typepay;
    data['curr_id'] = currId;
    data['curr_name'] = currName;
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['descr'] = descr;
    data['descount'] = descount;
    data['image'] = image;
    data['usr_id'] = usrId;
    data['date'] = date;
    data['date_cre'] = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
    data['totalprice'] = totalprice;
    if (bills != null) {
      data['bills'] = bills!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toJsonAdd() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accid'] = accId;
    data['accsecid'] = accSecId;
    data['typepay'] = typepay;
    // data['currid'] = currId; //null; //currId ?? 1;
    data['storeid'] = storeId; //null;
    data['descr'] = descr;
    data['descount'] = descount;
    // data['files'] = image;
    data['userid'] = usrId;
    data['date'] = date;
    data['datecre'] = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());

    data['table'] = table;

    return data;
  }

  Map<String, dynamic> toJsonEdit() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = invId;
    data['accid'] = accId;
    data['typepay'] = typepay;
    // data['currid'] = currId ?? "1";
    data['storeid'] = storeId;
    data['descr'] = descr;
    data['descount'] = descount;
    // data['files'] = image;
    data['userid'] = usrId;
    data['date'] = date;
    data['table'] = table;
    return data;
  }
}

class InvoiceBillsModel {
  dynamic id;
  dynamic invId;
  dynamic itmId;
  dynamic itmName;
  // dynamic itmNameAr;
  dynamic clrId;
  dynamic clrName;
  // dynamic clrNameAr;
  dynamic sizeId;
  dynamic sizeName;
  // dynamic sizeNameAr;
  dynamic qty;
  dynamic price;
  dynamic descount;
  dynamic usrId;
  dynamic date;
  dynamic table;

  InvoiceBillsModel({
    this.id,
    this.invId,
    this.itmId,
    this.clrId,
    this.sizeId,
    this.qty,
    this.price,
    this.descount,
    this.usrId,
    this.date,
    this.table,
    this.itmName,
    // this.itmNameAr,
    this.clrName,
    // this.clrNameAr,
    this.sizeName,
    // this.sizeNameAr
  });

  InvoiceBillsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    invId = json['inv_id'].toString();
    itmId = json['itm_id'].toString();
    itmName = json['itm_name'];
    // itmNameAr = json['itm_namear'];
    clrId = json['clr_id'].toString();
    clrName = json['clr_name'];
    // clrNameAr = json['clr_namear'];
    sizeId = json['siz_id'] != null
        ? json['siz_id'].toString()
        : json['size_id'].toString();
    sizeName = json['siz_name'];
    // sizeNameAr = json['siz_namear'];
    qty = json['qty'].toString();
    price = json['price'].toString();
    descount = json['descount'].toString();
    usrId = json['usr_id'].toString();
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['invid'] = invId;
    data['itm_id'] = itmId;
    data['clr_id'] = clrId;
    data['size_id'] = sizeId;
    data['qty'] = qty;
    data['price'] = price;
    data['descount'] = descount;
    data['usr_id'] = usrId;
    data['date'] = date;
    return data;
  }

  Map<String, dynamic> toJsonAdd() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['invid'] = invId;
    data['itmid'] = itmId;
    data['clrid'] = clrId;
    data['sizid'] = sizeId;
    data['qty'] = qty;
    data['price'] = price;
    data['descount'] = descount;
    data['userid'] = usrId;
    data['table'] = table;
    data['date'] = date;
    return data;
  }

  Map<String, dynamic> toJsonEdit() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['invid'] = invId;
    data['itmid'] = itmId;
    data['clrid'] = clrId;
    data['sizid'] = sizeId;
    data['qty'] = qty;
    data['price'] = price;
    data['descount'] = descount;
    data['userid'] = usrId;
    data['table'] = table;
    return data;
  }
}
