class Review {
  String? rate;
  late List<Data> _data;

  List<Data> get datas => _data;

  Review({required data, required rate}) {
    this._data = data;
    this.rate = rate;
  }

  Review.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
      });
    }
    rate = json['rate'];
  }
}

class Data {
  late List<User> _data;

  List<User> get datas => _data;
  int? id ;
  String? rate ;
  String? review ;
  String? userId ;
  String? serviceProviderId;
  DateTime? createdAt;
  String? updatedAt;
  User? user;

  Data({
    this.id,
    this.rate,
    this.review,
    this.userId,
    this.serviceProviderId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rate = json['rate'];
    review = json['review'];
    userId = json['user_id'];
    serviceProviderId = json['service_provider_id'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? name;
  String? profilePicture;

  User({this.id, this.name, this.profilePicture});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_picture'] = this.profilePicture;
    return data;
  }
}
