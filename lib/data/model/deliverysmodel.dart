class DeliverysModel {
  dynamic deliveryId;
  dynamic deliveryName;
  dynamic deliveryEmail;
  dynamic deliveryPassword;
  dynamic deliveryPhone;
  dynamic deliveryVerifycode;
  dynamic deliveryApprove;
  dynamic deliveryCreate;

  DeliverysModel(
      {this.deliveryId,
      this.deliveryName,
      this.deliveryEmail,
      this.deliveryPassword,
      this.deliveryPhone,
      this.deliveryVerifycode,
      this.deliveryApprove,
      this.deliveryCreate});

  DeliverysModel.fromJson(Map<String, dynamic> json) {
    deliveryId = json['delivery_id'];
    deliveryName = json['delivery_name'];
    deliveryEmail = json['delivery_email'];
    deliveryPassword = json['delivery_password'];
    deliveryPhone = json['delivery_phone'];
    deliveryVerifycode = json['delivery_verifycode'];
    deliveryApprove = json['delivery_approve'];
    deliveryCreate = json['delivery_create'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['delivery_id'] = deliveryId;
    data['delivery_name'] = deliveryName;
    data['delivery_email'] = deliveryEmail;
    data['delivery_password'] = deliveryPassword;
    data['delivery_phone'] = deliveryPhone;
    data['delivery_verifycode'] = deliveryVerifycode;
    data['delivery_approve'] = deliveryApprove;
    data['delivery_create'] = deliveryCreate;
    return data;
  }
}
