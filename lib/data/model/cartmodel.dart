import 'package:school_management/data/model/colormodel.dart';

class CartModel {
  List<ColorModel>? listColor;
  List<dynamic>? listitemImages;
  CartModel({this.listColor, this.listitemImages});
  CartModel.fromJsonOrder(Map<String, dynamic> json) {
    if (json['cartcolors'] != null) {
      listColor = [];
      json["cartcolors"].forEach((v) {
        listColor!.add(ColorModel.fromJsonCart(v));
      });
    }
  }
}
