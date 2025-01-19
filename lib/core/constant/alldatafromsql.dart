import 'dart:convert';

import 'package:school_management/core/funcations/logout.dart';
import 'package:school_management/core/services/services.dart';
import 'package:school_management/data/model/accountsmodel.dart';
import 'package:school_management/data/model/categoriesmodel.dart';
import 'package:school_management/data/model/colormodel.dart';
import 'package:school_management/data/model/customermodel.dart';
import 'package:school_management/data/model/documentsmodel.dart';
import 'package:school_management/data/model/invoicemodel.dart';
import 'package:school_management/data/model/itemscolorsizesmodel.dart';
import 'package:school_management/data/model/itemsmodel.dart';
import 'package:school_management/data/model/oderdetalismodel.dart';
import 'package:school_management/data/model/sizemodel.dart';
import 'package:school_management/data/model/usersmodel.dart';
import 'package:school_management/data/model/vendormodel.dart';

List<UsersModel> allListUsers = [];
List<VendorModel> allListVendors = [];
List<CustomerModel> allListCustomers = [];

List<CategoriesModel> allListCategories = [];
List<ItemsModel> allListItems = [];
List<ColorModel> allListColors = [];
List<SizeModel> allListSizes = [];
List<ItemColorSizeModel> allListItemColorSizes = [];

List<AccountsModel> allListAccountsInvoice = [];
List<AccountsModel> allListBoxs = [];
List<AccountsModel> allListStores = [];

List<InvoiceModel> allListInvoices = [];
List<InvoiceBillsModel> allListInvoicesBills = [];
List<DocumentModel> allListReciepts = [];
List<DocumentModel> allListPayments = [];
List<OrderModel> allListOrders = [];
List<OrderModel> allOrdersAccepted = [];
List<OrderModel> allOrdersPending = [];
List<OrderModel> allOrdersArchive = [];

addOneNewDataFromSql(var response, String tableName) {
  bool isNewUser = myServices.sharedPreferences.getBool("isnewuser") ?? false;
  if (isNewUser) {
  } else {
    String alldata = myServices.sharedPreferences.getString("alldata") ?? "";
    if (alldata.isEmpty) {
    } else {
      var res = jsonDecode(alldata);
      // Map<String, dynamic> dataOneTable = res[tableName];
      // dataOneTable.a
      res[tableName] = response['data'];
      String encodedMap = json.encode(res);
      myServices.sharedPreferences.remove("alldata");
      myServices.sharedPreferences.setString("alldata", encodedMap);
    }
  }
}

addAllUsersFromSqlIntoShared(List<UsersModel> list) async {
  String encodedMap = json.encode(list);
  await myServices.sharedPreferences.setString("allusers", encodedMap);
  await myServices.sharedPreferences.setBool("isnewallusers", false);
}

addAllVendorsFromSqlIntoShared(List<VendorModel> list) async {
  String encodedMap = json.encode(list);
  await myServices.sharedPreferences.setString("allvendors", encodedMap);
  await myServices.sharedPreferences.setBool("isnewallvendors", false);
}

addAllCustomersFromSqlIntoShared(List<UsersModel> list) {}
addAllCategoriesFromSqlIntoShared(List<UsersModel> list) {}
addAllItemsFromSqlIntoShared(List<UsersModel> list) {}
addAllColorsFromSqlIntoShared(dynamic listMap) async {
  String encodedMap = json.encode(listMap);
  await myServices.sharedPreferences.setString("allcolors", encodedMap);
  await myServices.sharedPreferences.setBool("isnewallcolors", false);
}

addNewColorFromSqlIntoShared(dynamic map) async {
  allListColors = getAllColorsFromShared();

  ColorModel color = ColorModel.fromJson(jsonDecode(map));

  allListColors.add(color);

  String encodedMap = json.encode(allListColors);
  await myServices.sharedPreferences.setString("allcolors", encodedMap);
  // if (Get.currentRoute == AppRoute.colorsAddpage ||
  //     Get.currentRoute == AppRoute.colorspage ||
  //     Get.currentRoute == AppRoute.colorsEditpage) {
  //   ViewColorsControllerImp view = Get.find();
  //   view.updateDataFromSql();
  // }
}

editOneColorFromSqlIntoShared(dynamic map) async {
  allListColors = getAllColorsFromShared();
  dynamic data = jsonDecode(map);

  int index = allListColors
      .indexWhere((element) => element.id.toString() == data["id"].toString());
  ColorModel color = allListColors.singleWhere(
    (element) => element.id.toString() == data["id"].toString(),
    orElse: () => ColorModel(),
  );
  if (color.id != null) {
    color.name = data["name"].toString();
    color.rgb = data["rgb"].toString();
    allListColors[index] = color;
  }

  String encodedMap = json.encode(allListColors);
  await myServices.sharedPreferences.setString("allcolors", encodedMap);
  // if (Get.currentRoute == AppRoute.colorsAddpage ||
  //     Get.currentRoute == AppRoute.colorspage ||
  //     Get.currentRoute == AppRoute.colorsEditpage) {
  //   ViewColorsControllerImp view = Get.find();
  //   view.updateDataFromSql();
  // }
}

deleteOneColorFromSqlIntoShared(dynamic map) async {
  allListColors = getAllColorsFromShared();
  dynamic data = jsonDecode(map);

  allListColors
      .removeWhere((element) => element.id.toString() == data["id"].toString());

  String encodedMap = json.encode(allListColors);
  await myServices.sharedPreferences.setString("allcolors", encodedMap);
  // if (Get.currentRoute == AppRoute.colorsAddpage ||
  //     Get.currentRoute == AppRoute.colorspage ||
  //     Get.currentRoute == AppRoute.colorsEditpage) {
  //   ViewColorsControllerImp view = Get.find();
  //   view.updateDataFromSql();
  // }
}

List<ColorModel> getAllColorsFromShared() {
  String? shared = myServices.sharedPreferences.getString("allcolors");
  if (shared != null) {
    List listMap = json.decode(shared);
    List<ColorModel> listColors = [];
    listColors.addAll(listMap.map((e) => ColorModel.fromJson(e)));

    allListColors = listColors;
    return listColors;
  } else {
    allListColors = [];
    return [];
  }
}

addAllSizesFromSqlIntoShared(dynamic listMap) async {
  String encodedMap = json.encode(listMap);
  await myServices.sharedPreferences.setString("allsizes", encodedMap);
  await myServices.sharedPreferences.setBool("isnewallsizes", false);
}

addNewSizeFromSqlIntoShared(dynamic map) async {
  allListSizes = getAllSizesFromShared();

  SizeModel size = SizeModel.fromJson(jsonDecode(map));

  allListSizes.add(size);

  String encodedMap = json.encode(allListSizes);
  await myServices.sharedPreferences.setString("allsizes", encodedMap);
  // if (Get.currentRoute == AppRoute.sizesAddpage ||
  //     Get.currentRoute == AppRoute.sizespage ||
  //     Get.currentRoute == AppRoute.sizesEditpage) {
  //   ViewSizesControllerImp view = Get.find();
  //   view.updateDataFromSql();
  // }
}

editOneSizeFromSqlIntoShared(dynamic map) async {
  allListSizes = getAllSizesFromShared();
  dynamic data = jsonDecode(map);

  int index = allListSizes
      .indexWhere((element) => element.id.toString() == data["id"].toString());
  SizeModel size = allListSizes.singleWhere(
    (element) => element.id.toString() == data["id"].toString(),
    orElse: () => SizeModel(),
  );
  if (size.id != null) {
    size.name = data["name"].toString();
    size.symbol = data["symbol"].toString();
    allListSizes[index] = size;
  }

  String encodedMap = json.encode(allListSizes);
  await myServices.sharedPreferences.setString("allsizes", encodedMap);
  // if (Get.currentRoute == AppRoute.sizesAddpage ||
  //     Get.currentRoute == AppRoute.sizespage ||
  //     Get.currentRoute == AppRoute.sizesEditpage) {
  //   ViewSizesControllerImp view = Get.find();
  //   view.updateDataFromSql();
  // }
}

deleteOneSizeFromSqlIntoShared(dynamic map) async {
  allListSizes = getAllSizesFromShared();
  dynamic data = jsonDecode(map);

  allListSizes
      .removeWhere((element) => element.id.toString() == data["id"].toString());

  String encodedMap = json.encode(allListSizes);
  await myServices.sharedPreferences.setString("allsizes", encodedMap);
  // if (Get.currentRoute == AppRoute.sizesAddpage ||
  //     Get.currentRoute == AppRoute.sizespage ||
  //     Get.currentRoute == AppRoute.sizesEditpage) {
  //   ViewSizesControllerImp view = Get.find();
  //   view.updateDataFromSql();
  // }
}

List<SizeModel> getAllSizesFromShared() {
  String? shared = myServices.sharedPreferences.getString("allsizes");
  if (shared != null) {
    List listMap = json.decode(shared);
    List<SizeModel> listSizes = [];
    listSizes.addAll(listMap.map((e) => SizeModel.fromJson(e)));

    allListSizes = listSizes;
    return listSizes;
  } else {
    allListSizes = [];
    return [];
  }
}

addAllItemColorSizesFromSqlIntoShared(List<UsersModel> list) {}
addAllBoxsFromSqlIntoShared(List<UsersModel> list) {}
addAllStoresFromSqlIntoShared(List<UsersModel> list) {}
addAllInvoicesFromSqlIntoShared(List<UsersModel> list) {}
addAllInvoicesBillsFromSqlIntoShared(List<UsersModel> list) {}
addAllRecieptsFromSqlIntoShared(List<UsersModel> list) {}
addAllPaymentsFromSqlIntoShared(List<UsersModel> list) {}
addAllOrdersFromSqlIntoShared(List<UsersModel> list) {}

addAllDataFromSqlIntoShared(var response) async {
  List list = [];

  list = response["vendors"];
  allListVendors.addAll(list.map((e) => VendorModel.fromJson(e)));

  list = response["customers"];
  allListCustomers.addAll(list.map((e) => CustomerModel.fromJson(e)));

  list = response["categories"];
  allListCategories.addAll(list.map((e) => CategoriesModel.fromJson(e)));

  list = response["items"];
  allListItems.addAll(list.map((e) => ItemsModel.fromJson(e)));

  list = response["colors"];
  allListColors.addAll(list.map((e) => ColorModel.fromJson(e)));

  list = response["sizes"];
  allListSizes.addAll(list.map((e) => SizeModel.fromJson(e)));

  list = response["itemcolorsizes"];
  allListItemColorSizes.addAll(list.map((e) => ItemColorSizeModel.fromJson(e)));

  list = response["boxs"];
  allListBoxs.addAll(list.map((e) => AccountsModel.fromJson(e)));

  list = response["stores"];
  allListStores.addAll(list.map((e) => AccountsModel.fromJson(e)));

  list = response["invoices"];
  allListInvoices.addAll(list.map((e) => InvoiceModel.fromJson(e)));

  list = response["reciepts"];
  allListReciepts.addAll(list.map((e) => DocumentModel.fromJson(e)));

  list = response["payments"];
  allListPayments.addAll(list.map((e) => DocumentModel.fromJson(e)));

  list = response["ordersaccepted"];
  allOrdersAccepted.addAll(list.map((e) => OrderModel.fromJson(e)));

  list = response["orderspending"];
  allOrdersPending.addAll(list.map((e) => OrderModel.fromJson(e)));

  list = response["ordersarchive"];
  allOrdersArchive.addAll(list.map((e) => OrderModel.fromJson(e)));

  String encodedMap = json.encode(response["data"]);
  await myServices.sharedPreferences.setString("alldata", encodedMap);
  await myServices.sharedPreferences.setBool("isnewuser", true);
}

updateAllDataFromSql(MyServices myServices, var response, String tableName) {
  String alldata = myServices.sharedPreferences.getString("alldata") ?? "";
  if (alldata.isEmpty) {
  } else {
    var res = jsonDecode(alldata);

    res[tableName] = response['data'];
    String encodedMap = json.encode(res);
    myServices.sharedPreferences.remove("alldata");
    myServices.sharedPreferences.setString("alldata", encodedMap);
  }
}
