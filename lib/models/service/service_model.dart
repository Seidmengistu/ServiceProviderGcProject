class Service {
  // to get data from the product model
  late List<ServiceModel> _services;
  //getter to get data from the _services to call from other class i.e make it public
  List<ServiceModel> get services => _services;

  //constractor
  Service({required services}) {
    //changed to create public field to use from other class in the Constarctor
    this._services = services;
  }

  Service.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      _services = <ServiceModel>[]; //assign to empty model
      json['services'].forEach((v) {
        _services.add(ServiceModel.fromJson(v)); //addd to the list
      });
    }
  }
}

class ServiceModel {
  int? id;
  String? name;
  String? description;
  String? price;
  String? type;
  String? image;
  String? serviceProviderId;
  String? createdAt;
  String? updatedAt;

  ServiceModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.type,
    this.image,
    this.serviceProviderId,
    this.createdAt,
    this.updatedAt,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json["price"];
    type = json['type'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    serviceProviderId = json['service_provider_id'];
  }
}
