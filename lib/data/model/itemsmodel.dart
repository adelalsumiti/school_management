import 'package:school_management/data/model/colormodel.dart';
import 'package:school_management/data/model/sizemodel.dart';

class ItemsModel {
  List<ColorModel>? colors;
  dynamic id;
  dynamic name;
  // dynamic nameAr;
  dynamic descr;
  // dynamic descrAr;
  dynamic itemsImage;
  dynamic itemsCount;
  dynamic itemsActive;
  dynamic pricePurch;
  dynamic priceSale;
  dynamic itemsDiscount;
  dynamic itemsDate;
  dynamic itemsCat;
  dynamic categoriesId;
  dynamic categoriesName;
  // dynamic categoriesNameAr;
  dynamic categoriesImage;
  dynamic categoriesDatetime;
  dynamic favorite;
  dynamic userid;
  dynamic itemsPriceDiscount;
  List<dynamic>? listImage;
  // dynamic image;
  dynamic cartid;

  ItemsModel(
      {this.id,
      this.name,
      // this.nameAr,
      this.descr,
      // this.descrAr,
      this.itemsImage,
      this.itemsCount,
      this.itemsActive,
      this.pricePurch,
      this.priceSale,
      this.itemsDiscount,
      this.itemsDate,
      this.itemsCat,
      this.itemsPriceDiscount,
      this.categoriesId,
      this.categoriesName,
      // this.categoriesNameAr,
      this.categoriesImage,
      this.categoriesDatetime,
      this.favorite,
      this.listImage = const [],
      this.colors = const [],
      this.userid,
      this.cartid});

  ItemsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    descr = json['descr'];
    itemsActive = json['active'].toString();
    priceSale = json['price_sale'].toString();
    pricePurch = json['price_purch'].toString();
    itemsDiscount = json['descount'].toString();
    categoriesId = json['cat_id'].toString();

    itemsImage = json['image'];
    itemsDate = json['date'];
    // categoriesNameAr = json['cat_name_ar'];
    listImage = json["allimages"] ?? [];
    userid = json["usr_id"].toString();
  }
  ItemsModel.fromJsonWithColor(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    // nameAr = json['name_ar'];
    descr = json['descr'];
    // descrAr = json['descr_ar'];
    itemsImage = json['image'];
    itemsCount = json['qty'].toString();
    itemsActive = json['active'].toString();
    priceSale = json['price_sale'].toString();
    pricePurch = json['price_purch'].toString();
    itemsDiscount = json['descount'].toString();
    itemsDate = json['date'];
    categoriesId = json['cat_id'].toString();
    categoriesName = json['cat_name'];
    // categoriesNameAr = json['cat_name_ar'];
    listImage = json["allimages"] ?? [];
    userid = json["usr_id"].toString();
    if (json["colors"] != null) {
      colors = [];
      json["colors"].forEach((v) {
        colors!.add(ColorModel.fromJsonItem(v));
      });
    }
  }
  ItemsModel.fromJsonOrderWithColor(Map<String, dynamic> json) {
    id = json['itm_id'].toString();
    name = json['itm_name'];
    // nameAr = json['itm_namear'];
    descr = json['itm_descr'];
    // descrAr = json['itm_descrar'];
    itemsImage = json['itm_image'];
    priceSale = json['totalprice'].toString();

    userid = json["usr_id"].toString();
    if (json["colors"] != null) {
      colors = [];
      json["colors"].forEach((v) {
        colors!.add(ColorModel.fromJsonOrder(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['itm_id'] = id;
    data['name'] = name;
    // data['namear'] = nameAr;
    data['descr'] = descr;
    // data['descrar'] = descrAr;
    data['pricesale'] = priceSale;
    data['pricepurch'] = pricePurch;
    data['descount'] = itemsDiscount;
    data['catid'] = categoriesId;
    data['userid'] = userid;
    return data;
  }
}

class ColorWithSizeModel {
  ColorModel? color;
  List<SizeModel>? sizes;

  ColorWithSizeModel({this.color, this.sizes});
}
