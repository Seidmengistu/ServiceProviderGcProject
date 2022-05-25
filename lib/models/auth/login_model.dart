class LoginModelBody {
  String phone;
  String code;
  String device;
  LoginModelBody(
      {
        required this.phone, 
        required this.code, 
        required this.device
        }
        );

  //CREATE METHOD TO CHANGE DATA RO JSON OBJECT TO USE IN AUTHREPO WITH APICLIENT.....
//convert object to Json
     
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    print(data.entries);
    data['phone_number'] = this.phone;
    data['code'] = this.code;
    data['device_name'] = this.device;

    return data;
  }
}
