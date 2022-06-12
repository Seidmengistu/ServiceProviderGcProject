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
        businessName: json['business_name'],
        phoneNumber: json['phone_number'],
        ownerName: json['owner_name'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        logo: json['logo'],
        type: json['type'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
