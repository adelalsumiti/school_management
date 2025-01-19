class AccountsModel {
  dynamic id;
  dynamic fatherId;
  dynamic name;
  dynamic type;
  dynamic finals;
  dynamic isactive;
  dynamic userId;
  dynamic date;
  bool isEdit = false;

  AccountsModel(
      {this.id,
      this.fatherId,
      this.name,
      this.type,
      this.finals,
      this.isactive,
      this.userId,
      this.isEdit = false,
      this.date});

  AccountsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    fatherId = json['father_id'].toString();
    name = json['name'];
    type = json['type'].toString();
    finals = json['final'].toString();
    isactive = json['isactive'].toString();
    userId = json['usr_id'].toString();
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['father_id'] = fatherId;
    data['name'] = name;
    data['type'] = type;
    data['final'] = finals;
    data['isactive'] = isactive;
    data['usr_id'] = userId;
    data['date'] = date;
    return data;
  }

  Map<String, dynamic> toJsonAdd() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['father'] = fatherId;
    data['name'] = name;
    data['type'] = type;
    data['final'] = finals;
    data['userid'] = userId;
    data['date'] = date;
    return data;
  }

  Map<String, dynamic> toJsonEdit() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accid'] = id;
    data['name'] = name;
    data['userid'] = userId;
    return data;
  }
}
