class Withdraw {
 late List<WithdrawModel> _data;
  List<WithdrawModel> get data => _data; 
  int? totalWithdraw;
 

  Withdraw({required data, required totalWithdraw}) {
    this._data = data;
    this.totalWithdraw = totalWithdraw;
  }

  Withdraw.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <WithdrawModel>[];
      json['data'].forEach((v) {
        _data.add(new WithdrawModel.fromJson(v));
      });
    }
    totalWithdraw = json['total_withdraw'];
   
  }

}

class WithdrawModel {
  int? id;
  String? amount;
  String? serviceProviderId;
  String? status;
  DateTime? createdAt;
  String? updatedAt;

  WithdrawModel(
      {this.id,
      this.amount,
      this.serviceProviderId,
      this.status,
      this.createdAt,
      this.updatedAt});

  WithdrawModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    serviceProviderId = json['service_provider_id'];
    status = json['status'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = json['updated_at'];
  }

 

}


