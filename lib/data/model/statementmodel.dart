class StatementModel {
  dynamic credit;
  dynamic debit;
  dynamic currid;
  dynamic currname;
  dynamic typedoc;
  dynamic docid;
  dynamic date;
  dynamic descr;
  dynamic accid;
  dynamic accname;

  StatementModel(
    this.accid,
    this.accname,
    this.credit,
    this.currid,
    this.currname,
    this.date,
    this.debit,
    this.descr,
    this.docid,
    this.typedoc,
  );

  StatementModel.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    debit = json['debit'];
    credit = json['credit'];
    currid = json['curr_id'];
    currname = json['curr_name'];
    typedoc = json['typedoc'];
    docid = json['docid'];
    descr = json['descr'];

    date = json['date'];
    accid = json['acc_id'];
    accname = json['acc_name'];
  }
}
