class StoreModel {
  dynamic allStore;
  dynamic allItem;
  dynamic groupBy;
  // int? qtyByItem;
  // int? qtyByColor;
  // int? qtyBySize;
  // int? qtyIsZero;
  // int? qtyMoreZero;
  // int? qtyLessZero;
  dynamic allQty;
  dynamic itemID;
  dynamic storeID;
  // dynamic colorID;
  // dynamic sizeID;
  dynamic type;
  bool? isEdit;
  // StatusRequest? statusRequest;

  StoreModel({
    this.allItem,
    this.allStore,
    // this.colorID,
    this.itemID,
    // this.qtyByColor,
    // this.qtyByItem,
    // this.qtyBySize,
    // this.qtyIsZero,
    // this.qtyLessZero,
    // this.qtyMoreZero,
    // this.sizeID,
    this.storeID,
    this.allQty,
    this.type,
    this.groupBy,
    this.isEdit,
  });
  Map<String, dynamic> toJson() {
    return {
      "allStore": allStore ?? "0",
      "allItem": allItem ?? "0",
      "allQty": allQty ?? "0",
      "groupBy": groupBy ?? "0",
      // "qtyByColor": qtyByColor != null ? qtyByColor.toString() : "0",
      // "qtyBySize": qtyBySize != null ? qtyBySize.toString() : "0",
      "itemID": itemID ?? "0",
      "storeID": storeID ?? "0"
    };
  }
}
