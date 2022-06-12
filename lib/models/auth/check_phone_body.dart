class CheckPhoneNumberBody {
  String phone;
  CheckPhoneNumberBody({required this.phone});

  //CREATE METHOD TO CHANGE DATA RO JSON OBJECT TO USE IN AUTHREPO WITH APICLIENT.....

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['phone_number'] = this.phone;
    
    return data;
  }
}
