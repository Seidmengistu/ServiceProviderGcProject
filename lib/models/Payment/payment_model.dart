class PaymentBody {
  String accountNumber;
  String accountHolder;
  String paymentMethod;
  

  PaymentBody(
      {required this.accountNumber,
      required this.accountHolder,
      required this.paymentMethod,
      });

      //convert object to Json
      Map<String,dynamic> toJson(){
        final Map<String,dynamic> data=new Map<String,dynamic>();
        data["account_number"]=this.accountNumber;
        data["account_holder"]=this.accountHolder;
        data["payment_method"]=this.paymentMethod;
        return data;
      }
}
