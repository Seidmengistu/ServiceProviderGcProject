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
  String? id;
  String? name;
  String? description;
  double? price;
  int? type;
  String? image;
  int? serviceProviderId;
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
    id = json['id'].toString();
    name = json['name'].toString();
    description = json['description'].toString();
    price = double.tryParse(json["price"]);
    type = int.tryParse(json['type']);
    image = json['image'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    serviceProviderId = int.tryParse(json['service_provider_id']);
  }
}
