class ItemColorSizeModel {
  dynamic id;
  dynamic itemid;
  dynamic colorid;
  dynamic sizeid;
  dynamic pricePurch;
  dynamic priceSale;
  dynamic descount;
  dynamic userid;
  dynamic dateTime;

  ItemColorSizeModel(
      {this.id,
      this.colorid,
      this.sizeid,
      this.pricePurch,
      this.descount,
      this.userid,
      this.dateTime,
      this.priceSale,
      this.itemid});

  ItemColorSizeModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];

    itemid = json["itm_id"];
    colorid = json["clr_id"];
    sizeid = json["size_id"];
    pricePurch = json["price_purch"];
    priceSale = json["price_sale"];
    descount = json["descount"];
    dateTime = json["date"];
    userid = json["usr_id"];
  }
}
