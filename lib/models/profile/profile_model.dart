import 'package:service_provider/utils/app_constants.dart';

class Profile {
  // int? id;
  String? businessName;
  String? phoneNumber;
  String? ownerName;
  String? latitude;
  String? longitude;
  String? logo;
  String? type;
  String? createdAt;
  String? updatedAt;

  Profile(
      {
      // this.id,
      this.businessName,
      this.phoneNumber,
      this.ownerName,
      this.latitude,
      this.longitude,
      this.logo,
      this.type,
      this.createdAt,
      this.updatedAt});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        businessName:
            json['business_name'] == null ? "" : json['business_name'],
        phoneNumber: json['phone_number'] == null ? "" : json['phone_number'],
        ownerName: json['owner_name'] == null ? "" : json['owner_name'],
        latitude: json['latitude'] == null ? "" : json['latitude'],
        longitude: json['longitude'] == null ? "" : json['longitude'],
        logo: json['logo'] == null
            ? AppConstants.BASE_URL + AppConstants.UPLOAD_URL + ""
            : json['logo'],
        type: json['type'] == null ? "" : json['type'],
        createdAt: json['created_at'] == null ? "" : json['created_at'],
        updatedAt: json['updated_at'] == null ? "" : json['updated_at']);
  }
}
