
class CategoriesModel {
  dynamic id;
  dynamic name;
  // dynamic nameAr;
  dynamic image;
  dynamic newImage;
  dynamic date;
  dynamic userid;

  CategoriesModel(
      {this.id,
      this.name,
      // this.nameAr,
      this.image,
      this.newImage,
      this.date,
      this.userid});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    // nameAr = json['name_ar'];
    image = json['image'];
    date = json['date'];
    userid = json["usr_id"].toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["cat_id"] = id;
    data['cat_name'] = name;
    // data['cat_name_ar'] = nameAr;
    data['cat_image'] = image;
    data['cat_datetime'] = date;
    data['userid'] = userid;
    return data;
  }

  Map<String, dynamic> toJsonAdd() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    // data['namear'] = nameAr;
    // data['files'] = newImage;
    data['userid'] = userid;
    data["date"] = date;
    return data;
  }

  Map<String, dynamic> toJsonEdit() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['name'] = name;
    // data['namear'] = nameAr;
    data['imageold'] = image;
    data["userid"] = userid;

    // data['cat_datetime'] = date;
    return data;
  }

  Map<String, dynamic> toJsonDelete() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat_id'] = id;
    // data['name'] = name;
    // data['namear'] = nameAr;
    data['imagename'] = image;
    // data['cat_datetime'] = date;
    return data;
  }
}
