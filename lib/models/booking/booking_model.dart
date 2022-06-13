class Booking {
  late List<Data> _data;

  List<Data> get data => _data;

  Booking({required data}) {
    this._data = data;
  }
  Booking.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  late List<User> _data;

  List<User> get datas => _data;

  String? id;
  String? serviceId;
  String? serviceProviderId;
  String? userId;
  String? status;
  String? serviceDate;
  String? createdAt;
  String? updatedAt;
  User? user;
  Service? service;

  Data({
    this.id,
    this.serviceId,
    this.serviceProviderId,
    this.userId,
    this.status,
    this.serviceDate,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.service,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <User>[];
      json['data'].forEach((v) {
        _data.add(new User.fromJson(v));
      });
    }
    id = json['id'];
    serviceId = json['service_id'];
    serviceProviderId = json['service_provider_id'];
    userId = json['user_id'];
    status = json['status'];
    serviceDate = json['service_data'] == null ? "" : json['service_data'];
    createdAt = json['created_at'] == null ? "" : json['created_at'];
    updatedAt = json['updated_at'] == null ? "" : json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
  }
}

class User {
  int? id;
  String? name;
  String? phoneNumber;
  String? emailVerifiedAt;
  DateTime? createdAt;
  String? updatedAt;
  String? profilePicture;

  User(
      {this.id,
      this.name,
      this.phoneNumber,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.profilePicture});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = json['updated_at'];
    profilePicture = json['profile_picture'];
  }
}

class Service {
  int? id;
  String? name;
  String? description;
  String? price;
  String? type;
  String? image;
  String? serviceProviderId;
  String? createdAt;
  String? updatedAt;

  Service(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.type,
      this.image,
      this.serviceProviderId,
      this.createdAt,
      this.updatedAt});

  Service.fromJson(Map<String, dynamic> json) {
    // print(json['name']);
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    type = json['type'];
    image = json['image'];
    serviceProviderId = json['service_provider_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
