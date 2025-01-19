class SizeModel {
  dynamic id;
  dynamic itmclrsizid;
  dynamic name;
  // dynamic namear;
  dynamic symbol;
  dynamic qty;
  dynamic pricePurch;
  dynamic priceSale;

  dynamic descount;
  dynamic userid;
  dynamic dateTime;
  dynamic qtycart;
  dynamic saleQty;
  dynamic totalQty;
  bool? isSelected = false;
  // StatusRequest? statusRequest;

  SizeModel(
      {this.id,
      this.name,
      // this.namear,
      this.symbol,
      this.qty,
      this.pricePurch,
      this.descount,
      this.userid,
      this.dateTime,
      this.qtycart,
      this.isSelected,
      this.saleQty,
      this.totalQty,
      this.priceSale,
      this.itmclrsizid});

  SizeModel.fromJson(Map<String, dynamic> json) {
    id = json["id"].toString();
    name = json["name"];
    // namear = json["name_ar"];
    symbol = json["symbol"];
    userid = json["usr_id"].toString();
    dateTime = json["date"];
  }
  SizeModel.fromJsonColor(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    // namear = json["name_ar"];
    symbol = json['symbol'];
    qty = json['qty'];
    qtycart = json["qty_cart"];
    pricePurch = json["price_purch"];
    priceSale = json["price_sale"];
    descount = json["descount"];
  }
  SizeModel.fromJsonItemColor(Map<String, dynamic> json) {
    itmclrsizid = json["id"];
    id = json["size_id"];
    name = json["name"];
    // namear = json["name_ar"];
    symbol = json['symbol'];
    qty = json['qty'];
    pricePurch = json["price_purch"];
    priceSale = json["price_sale"];
    descount = json["descount"];
    dateTime = json["date"];
    userid = json["usr_id"];
    // statusRequest = StatusRequest.none;
  }
  SizeModel.fromJsonOrderColor(Map<String, dynamic> json) {
    // itmclrsizid = json["id"];
    id = json["size_id"];
    name = json["name"];
    // namear = json["name_ar"];
    symbol = json['symbol'];
    qty = json['qty'];
    pricePurch = json["price"];
    descount = json["descount"];
    dateTime = json["date"];
    userid = json["usr_id"];
    // statusRequest = StatusRequest.none;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "name": name.toString(),
      // "namear": namear.toString(),
      "symbol": symbol.toString(),
      "userid": userid.toString(),
      // "siz_usr_id": userid,
      // "siz_datetime":dateTime,
      // "quantity": quantity,
      // "saleQty": saleQty,
      // "totalQty": totalQty,
      // "isSelected": isSelected
    };
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "name": name,
      "date": dateTime,
      "symbol": symbol,
      "userid": userid,
    };
  }
}
