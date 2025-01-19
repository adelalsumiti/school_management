class InventoryColumnsModel {
  dynamic storeid;
  dynamic storename;
  dynamic itemid;
  dynamic itemname;
  // dynamic itemnamear;
  dynamic colorid;
  dynamic colorname;
  // dynamic colornamear;
  dynamic sizeid;
  dynamic sizename;
  // dynamic sizenamear;
  dynamic inputQty;
  dynamic outputQty;
  dynamic totalQty;
  dynamic purchPrice;
  dynamic salePrice;
  dynamic totalPrice;

  InventoryColumnsModel(
    this.itemid,
    this.itemname,
    this.storeid,
    this.storename,
    this.inputQty,
    // this.itemnamear,
    this.outputQty,
    this.purchPrice,
    this.salePrice,
    this.sizeid,
    this.sizename,
    // this.sizenamear,
    this.totalPrice,
    this.totalQty,
    this.colorid,
    this.colorname,
    // this.colornamear
  );

  InventoryColumnsModel.fromJsonItem(Map<String, dynamic> json) {
    // id = json['id'];
    storeid = json['store_id'];
    storename = json['store_name'];
    itemid = json['itm_id'];
    itemname = json['itm_name'];
    // itemnamear = json['itm_name_ar'];
    totalQty = json['qty'];
    salePrice = json['price_sale'];
  }
  InventoryColumnsModel.fromJsonColor(Map<String, dynamic> json) {
    // id = json['id'];
    storeid = json['store_id'];
    storename = json['store_name'];
    itemid = json['itm_id'];
    itemname = json['itm_name'];
    // itemnamear = json['itm_name_ar'];
    colorid = json['clr_id'];
    colorname = json['clr_name'];
    // colornamear = json['clr_name_ar'];
    totalQty = json['qty'];
    salePrice = json['price_sale'];
  }
  InventoryColumnsModel.fromJsonSize(Map<String, dynamic> json) {
    // id = json['id'];
    storeid = json['store_id'];
    storename = json['store_name'];
    itemid = json['itm_id'];
    itemname = json['itm_name'];
    // itemnamear = json['itm_name_ar'];
    colorid = json['clr_id'];
    colorname = json['clr_name'];
    // colornamear = json['clr_name_ar'];
    sizeid = json['size_id'];
    sizename = json['siz_name'];
    // sizenamear = json['siz_name_ar'];
    totalQty = json['qty'];
    salePrice = json['price_sale'];
  }
}
