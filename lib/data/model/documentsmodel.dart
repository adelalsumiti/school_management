class DocumentModel {
  dynamic id;
  dynamic amount;
  dynamic currId;
  dynamic currName;
  dynamic accId;
  dynamic accName;
  dynamic boxId;
  dynamic boxName;
  dynamic donor;
  dynamic descr;
  dynamic type;
  dynamic usrId;
  dynamic date;
  dynamic dateCre;
  dynamic table;

  DocumentModel(
      {this.id,
      this.amount,
      this.currId,
      this.currName,
      this.accId,
      this.accName,
      this.boxId,
      this.boxName,
      this.donor,
      this.descr,
      this.type,
      this.usrId,
      this.date,
      this.dateCre,
      this.table});

  DocumentModel.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      id = json['id'].toString();
      amount = json['amount'].toString();
      currId = json['curr_id'].toString();
      currName = json['curr_name'];
      accId = json['acc_id'].toString();
      accName = json['acc_name'];
      boxId = json['box_id'].toString();
      boxName = json['box_name'];
      donor = json['donor'];
      descr = json['descr'];
      type = json['type'].toString();
      usrId = json['usr_id'].toString();
      date = json['date'];
      dateCre = json['date_cre'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['amount'] = amount;
    // data['currid'] = currId;
    // data['curr_name'] = currName;
    data['accid'] = accId;
    // data['acc_name'] = accName;
    data['boxid'] = boxId;
    // data['box_name'] = boxName;
    data['donor'] = donor;
    data['descr'] = descr;
    data['type'] = type;
    data['userid'] = usrId;
    data['date'] = date;
    data['datecre'] = dateCre;
    data["table"] = table;
    return data;
  }

  Map<String, dynamic> toJsonEdit() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    // data['currid'] = currId;
    data['accid'] = accId;
    data['boxid'] = boxId;
    data['donor'] = donor;
    data['descr'] = descr;
    data['type'] = type;
    data['userid'] = usrId;
    data['date'] = date;
    data["table"] = table;
    return data;
  }

  Map<String, dynamic> toJsonDelete() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userid'] = usrId;
    data["table"] = table;
    return data;
  }
}
