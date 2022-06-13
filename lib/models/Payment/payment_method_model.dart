class PaymentModel {
  int id;
  String? acountHolder;
  String? accountnumber;
  String? paymenttype;

  PaymentModel({
    required this.id,
    this.acountHolder,
    this.accountnumber,
    this.paymenttype,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      acountHolder:
          json['account_holder'] == null ? "" : json['account_holder'],
      accountnumber:
          json['account_number'] == null ? "" : json['account_number'],
      paymenttype: json['payment_method'] == null ? "" : json['payment_method'],
    );
  }
}
