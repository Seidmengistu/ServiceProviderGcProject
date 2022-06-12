class WithdrawModel {
  int id;
  String? amount;

  WithdrawModel({
    required this.id,
    this.amount,
    
});

  factory WithdrawModel.fromJson(Map<String, dynamic> json) {
    return WithdrawModel(
    
      id: json['id'],
      amount: json['amount'],
    );
  }
}


