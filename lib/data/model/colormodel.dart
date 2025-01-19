import 'package:school_management/data/model/sizemodel.dart';

class ColorModel {
  dynamic id;
  dynamic name;
  // dynamic nameAr;
  dynamic userId;
  List<SizeModel>? sizes;
  dynamic rgb;
  bool isSelected = false;
  dynamic countSizes;
  dynamic dateTime;
  dynamic pricePurch;
  dynamic priceSale;

  dynamic descount;

  // StatusRequest? statusRequest;
  ColorModel(
      {this.id,
      this.name,
      // this.nameAr,
      this.userId,
      this.sizes = const [],
      this.rgb,
      isSelected,
      this.countSizes,
      this.dateTime,
      this.pricePurch,
      this.priceSale,
      this.descount});

  ColorModel.fromJson(Map<String, dynamic> json) {
    id = "${json['id']}";
    name = json['name'];
    // nameAr = json['name_ar'];
    rgb = json["rgb"];
    userId = json['usr_id'];
    dateTime = json['date'];
  }

  ColorModel.fromJsonItem(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    // nameAr = json['name_ar'];
    rgb = json['rgb'].toString();
    countSizes = json["countsizes"].toString();
    // statusRequest = StatusRequest.none;
    if (json['sizes'] != null) {
      sizes = <SizeModel>[];
      json['sizes'].forEach((v) {
        sizes!.add(SizeModel.fromJsonItemColor(v));
      });
    }
    // isSelected = json["isSelected"] ?? false;
    // if (json['sizes'] != null) {
    //   sizes = <SizeModel>[];
    //   json['sizes'].forEach((v) {
    //     sizes!.add(MySizes.fromJson(v));
    //   });
    // }
  }
  ColorModel.fromJsonOrder(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    // nameAr = json['name_ar'];
    rgb = json['rgb'];
    isSelected = false;
    if (json['sizes'] != null) {
      sizes = <SizeModel>[];
      json['sizes'].forEach((v) {
        sizes!.add(SizeModel.fromJsonOrderColor(v));
      });
    }
  }

  ColorModel.fromJsonCart(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    // nameAr = json['name_ar'];
    rgb = json["rgb"];
    dateTime = json["date"];
    userId = json["usr_id"];
    if (json['sizes'] != null) {
      sizes = [];
      json['sizes'].forEach((v) {
        sizes!.add(SizeModel.fromJsonItemColor(v));
      });
    }
    // userId = json['usr_id'];
    // dateTime = json['datetime'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    // data['namear'] = nameAr;
    data['userid'] = userId;
    data['rgb'] = rgb;
    // if (sizes != null) {
    //   data['sizes'] = sizes!.map((v) => v.toMap()).toList();
    // }
    return data;
  }

  Map<String, dynamic> toJsonAdd() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    // data['namear'] = nameAr;
    data['userid'] = userId;
    data['rgb'] = rgb;
    data["date"] = dateTime;
    // if (sizes != null) {
    //   data['sizes'] = sizes!.map((v) => v.toMap()).toList();
    // }
    return data;
  }
}
