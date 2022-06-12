import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:service_provider/base/custom_loader.dart';
import 'package:service_provider/base/show_custom_snackbar.dart';
import 'package:service_provider/controllers/payment/payment_controller.dart';
import 'package:service_provider/controllers/profile/profile_controller.dart';
import 'package:service_provider/controllers/review/review_controller.dart';
import 'package:service_provider/controllers/withdraw/withdraw_controller.dart';

import 'package:service_provider/utils/app_constants.dart';
import 'package:service_provider/utils/dimensions.dart';

import 'package:service_provider/widgets/big_text.dart';

import 'package:service_provider/widgets/res/assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportList extends StatefulWidget {
  const ReportList({Key? key}) : super(key: key);
  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  var controller = Get.find<PaymentController>();
  final String avatar = avatars[0];
  Widget build(BuildContext context) {
    Get.find<ReviewController>().getReviewList();
    final _profileInfo = Get.find<ProfileController>();
    final f = new DateFormat.yMd();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: Dimensions.height50 + 70,
          // centerTitle: true,
          flexibleSpace: Container(
            padding: EdgeInsets.only(top: Dimensions.height50 + 55),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimensions.radius30 + 50),
                    bottomRight: Radius.circular(Dimensions.radius30 + 50)),
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blue],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
            child: Column(
              children: [
                TabBar(
                  isScrollable: false,
                  indicatorColor: Colors.amberAccent,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(
                      // text: 'Review',
                      child: Text(
                        'Review',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.font16,
                            fontFamily: 'TiroKannada',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Payment',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.font16,
                            fontFamily: 'TiroKannada',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Withdraw',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.font16,
                            fontFamily: 'Roboto',
                            letterSpacing: 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Container(
          //    Wrap(
          // children: <Widget>Column);
          child: TabBarView(
            children: [
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GetBuilder<ReviewController>(builder: (reviewList) {
                        return Container(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: Dimensions.radius30 * 2,
                                backgroundImage: NetworkImage(
                                    AppConstants.BASE_URL +
                                        AppConstants.UPLOAD_URL +
                                        _profileInfo.profileInfo[0].logo
                                            .toString()),
                              ),
                              SizedBox(
                                height: Dimensions.height15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RatingBar.builder(
                                    ignoreGestures: true,
                                    itemSize: Dimensions.font26,
                                    initialRating: double.tryParse(
                                            reviewList.reviewList[0].rate)!
                                        .toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 0.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),
                                  SizedBox(
                                    width: Dimensions.width15,
                                  ),
                                  Text(
                                    reviewList.reviewList[0].rate + " " + "/ 5",
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.font16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                      SizedBox(
                        height: Dimensions.height15,
                      ),
                      Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showMaterialModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.white,
                                  elevation: 4,
                                  builder: (context) => Container(
                                    height: MediaQuery.of(context).size.height -
                                        180.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius30),
                                    ),
                                    child: GetBuilder<ReviewController>(
                                        builder: (reviewList) {
                                      return reviewList.isLoad
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  reviewList.reviewList.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  color: Colors.white,
                                                  margin: EdgeInsets.only(
                                                    top: Dimensions.height10,
                                                    left: Dimensions.width20,
                                                    right: Dimensions.width20,
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      top: Dimensions.height15),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: Dimensions
                                                                    .height15),
                                                        child: CircleAvatar(
                                                          maxRadius: Dimensions
                                                              .radius30,
                                                          backgroundImage:
                                                              NetworkImage(reviewList
                                                                  .reviewList[
                                                                      index]
                                                                  .user
                                                                  .profilePicture),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Wrap(
                                                          children: [
                                                            Container(
                                                              color:
                                                                  Colors.white,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: Dimensions
                                                                      .height10,
                                                                ),
                                                                child: Wrap(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        BigText(
                                                                          text: reviewList
                                                                              .reviewList[index]
                                                                              .user
                                                                              .name
                                                                              .toString(),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              Dimensions.width30,
                                                                        ),
                                                                        RatingBar
                                                                            .builder(
                                                                          ignoreGestures:
                                                                              true,
                                                                          itemSize:
                                                                              Dimensions.font26,
                                                                          initialRating:
                                                                              double.tryParse(reviewList.reviewList[index].rate)!.toDouble(),
                                                                          minRating:
                                                                              1,
                                                                          direction:
                                                                              Axis.horizontal,
                                                                          allowHalfRating:
                                                                              true,
                                                                          itemCount:
                                                                              5,
                                                                          itemPadding:
                                                                              EdgeInsets.symmetric(horizontal: 0.0),
                                                                          itemBuilder: (context, _) =>
                                                                              Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Colors.amber,
                                                                          ),
                                                                          onRatingUpdate:
                                                                              (rating) {},
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: Dimensions
                                                                          .width30,
                                                                    ),
                                                                    Text(
                                                                      f
                                                                          .format(reviewList
                                                                              .reviewList[index]
                                                                              .createdAt)
                                                                          .toString(),
                                                                    ),
                                                                    SizedBox(
                                                                      height: Dimensions
                                                                          .width30,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            reviewList.reviewList[index].review,
                                                                            textAlign:
                                                                                TextAlign.justify,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: Dimensions.font16,
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              })
                                          : CustomLoader(
                                              key: Key("Loading..."),
                                            );
                                    }),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.align_horizontal_left,
                                    size: Dimensions.height30,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: Dimensions.width20,
                                  ),
                                  Text(
                                    "See All Reviews",
                                    style: TextStyle(
                                        fontFamily: 'TiroKannada',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepOrange,
                                        fontSize: Dimensions.font16 + 2),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height50 * 2,
                            ),
                            Text("Popular Comments Here"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              paymetMethod(),
              withdraw(),
            ],
          ),
        ),
      ),
    );
  }
}

paymetMethod() {
  var info = Get.find<PaymentController>();
  var accountHolderControllerr = TextEditingController();
  var accountNumberControllerr = TextEditingController();
  var type = TextEditingController();
  var id = TextEditingController();
  var controller = Get.find<PaymentController>();
  void clearTextField() {
    controller.accountHolderController.clear();
    controller.accountNumberController.clear();
  }

  accountHolderControllerr.text =
      info.dashboardInformation[0].acountHolder.toString();
  accountNumberControllerr.text =
      info.dashboardInformation[0].accountnumber.toString();
  type.text = info.dashboardInformation[0].paymenttype.toString();
  id.text = info.dashboardInformation[0].id.toString();

//update services
  Dio.Dio dio = new Dio.Dio();

  Future<void> _updatePaymentMethod(String id) async {
    final String endPoint =
        "http://www.gcproject.awraticket.com/service_provider/edit_payment_method/" +
            id;

    String token = '';
    SharedPreferences pre = await SharedPreferences.getInstance();
    token = pre.getString(AppConstants.TOKEN) ?? "None token";
    String accountHolder = accountHolderControllerr.text.trim();
    String accountNumber = accountNumberControllerr.text.trim();
    String paymentType = controller.selectedType.value.toString();

    print(token);
    Dio.FormData formData = new Dio.FormData.fromMap({
      "account_number": accountNumber,
      "account_holder": accountHolder,
      "payment_method": paymentType,
    });
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.post(endPoint, data: formData).then((response) {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        Get.snackbar(
          "Success",
          "Payment Type Updated Successfully",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
          margin: EdgeInsets.all(15),
          forwardAnimationCurve: Curves.bounceOut,
        );
      }
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => print(error));
  }

  return DefaultTabController(
    length: 2,
    child: Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: new Size.fromHeight(20),
            child: Container(
              child: TabBar(
                isScrollable: false,
                indicatorWeight: 3.0,
                indicatorColor: Colors.blue[200],
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: <Widget>[
                  Tab(
                    // icon: Icon(
                    //   Icons.today,
                    //   color: Colors.green,
                    // ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 7,
                                offset: Offset(1, 10),
                                color: Colors.white.withOpacity(0.2))
                          ]),
                      child: Text(
                        'Add Payment Method',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.font16,
                            fontFamily: 'TiroKannada',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                  Tab(
                    // icon: Icon(
                    //   Icons.assessment,
                    //   color: Colors.green,
                    // ),
                    child: Text(
                      'Edit Payment Method',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.font16,
                          fontFamily: 'TiroKannada',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius30),
                  topRight: Radius.circular(Dimensions.radius30),
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(bottom: 30),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width50,
                            top: Dimensions.height50),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 23,
                                  spreadRadius: 0.1,
                                  offset: Offset(1, 2),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: SingleChildScrollView(
                          child: Column(
                            // mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(
                                      right: Dimensions.width20),
                                  padding: EdgeInsets.only(
                                    top: Dimensions.height20,
                                  ),
                                  child: Text("Add Payment Method",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'TiroKannada',
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1))),
                              _textInput(
                                  hint: "Account Holder",
                                  icon: Icons.person,
                                  controller:
                                      controller.accountHolderController),
                              _textInput(
                                  hint: "Account Number",
                                  icon: Icons.email,
                                  controller:
                                      controller.accountNumberController),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: Dimensions.height20,
                                    left: Dimensions.width20,
                                    right: Dimensions.width20),
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius30),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 12,
                                          spreadRadius: 5,
                                          offset: Offset(1, 10),
                                          color: Colors.grey.withOpacity(0.2))
                                    ]),
                                padding: EdgeInsets.only(left: 10),
                                child: Obx(
                                  () => DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.room_service,
                                        color: Colors.blue[900],
                                      ),
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: "1",
                                        child: Text(
                                          "CBE",
                                          style: TextStyle(
                                            fontSize: Dimensions.font20,
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: "2",
                                        child: Text(
                                          "Abissinia Bank",
                                          style: TextStyle(
                                            fontSize: Dimensions.font20,
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: "3",
                                        child: Text(
                                          "Dashen Bank",
                                          style: TextStyle(
                                            fontSize: Dimensions.font20,
                                          ),
                                        ),
                                      ),
                                    ],
                                    value: controller.selectedType.value
                                        .toString(),
                                    isExpanded: true,
                                    onChanged: (selectedValue) {
                                      controller.selectedType.value =
                                          int.parse(selectedValue!);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height50,
                              ),
                              Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [Colors.blue, Colors.blue],
                                          end: Alignment.centerLeft,
                                          begin: Alignment.centerRight),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(100),
                                      )),
                                  child: OutlineButton(
                                    child: Text(
                                      "Add",
                                      style: TextStyle(
                                          fontSize: Dimensions.font20),
                                    ),
                                    highlightedBorderColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.font16)),
                                    onPressed: () {
                                      if (controller.accountNumberController
                                          .text.isEmpty) {
                                        showCustomSnackBar(
                                            'Please Add Account Number',
                                            title: 'Error ');
                                      } else if (controller
                                          .accountHolderController
                                          .text
                                          .isEmpty) {
                                        showCustomSnackBar(
                                            'Please Add Account Holder Name',
                                            title: 'Error');
                                      } else {
                                        EasyLoading.show(status: "Saving...");
                                        controller.addPayment();
                                        // clearTextField();
                                      }
                                    },
                                  ))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius30),
                  topRight: Radius.circular(Dimensions.radius30),
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(bottom: 30),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width50,
                            top: Dimensions.height50),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 23,
                                  spreadRadius: 0.1,
                                  offset: Offset(1, 2),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: SingleChildScrollView(
                          child: Column(
                            // mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(
                                      right: Dimensions.width20),
                                  padding: EdgeInsets.only(
                                    top: Dimensions.height20,
                                  ),
                                  child: Text("Edit Payment Method",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'TiroKannada',
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1))),
                              _textInput(
                                  hint: "Account Holder",
                                  icon: Icons.person,
                                  controller: accountHolderControllerr),
                              _textInput(
                                  hint: "Account Number",
                                  icon: Icons.email,
                                  controller: accountNumberControllerr),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: Dimensions.height20,
                                    left: Dimensions.width20,
                                    right: Dimensions.width20),
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius30),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 12,
                                          spreadRadius: 5,
                                          offset: Offset(1, 10),
                                          color: Colors.grey.withOpacity(0.2))
                                    ]),
                                padding: EdgeInsets.only(left: 10),
                                child: Obx(
                                  () => DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.room_service,
                                        color: Colors.blue[900],
                                      ),
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: "1",
                                        child: Text(
                                          "CBE",
                                          style: TextStyle(
                                            fontSize: Dimensions.font20,
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: "2",
                                        child: Text(
                                          "Abissinia Bank",
                                          style: TextStyle(
                                            fontSize: Dimensions.font20,
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: "3",
                                        child: Text(
                                          "Dashen Bank",
                                          style: TextStyle(
                                            fontSize: Dimensions.font20,
                                          ),
                                        ),
                                      ),
                                    ],
                                    value: controller.selectedType.value
                                        .toString(),
                                    isExpanded: true,
                                    onChanged: (selectedValue) {
                                      controller.selectedType.value =
                                          int.parse(selectedValue!);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height50,
                              ),
                              Center(
                                child: FloatingActionButton.extended(
                                  label: Text("Update"),
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    if (accountHolderControllerr.text.isEmpty) {
                                      showCustomSnackBar(
                                          'Account Holder Name is Required',
                                          title: 'Error ');
                                    } else if (accountNumberControllerr
                                        .text.isEmpty) {
                                      showCustomSnackBar(
                                          'Account Number  is Required',
                                          title: 'Error');
                                    } else {
                                      EasyLoading.show(status: "Updating");
                                      _updatePaymentMethod(id.text.toString());
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

withdraw() {
  var info = Get.find<WithdrawController>();
  var amountController = TextEditingController();
  var id = TextEditingController();
  var controller = Get.find<WithdrawController>();
  var withdraw = Get.find<WithdrawController>().getWithdrawList();
  void clearTextField() {
    controller.amountController.clear();
  }

  final Color primaryColor = Color(0xffFD6592);
  final Color bgColor = Color(0xffF9E0E3);
  final Color secondaryColor = Color(0xff324558);

  return DefaultTabController(
    length: 2,
    child: Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: new Size.fromHeight(20),
            child: Container(
              child: TabBar(
                isScrollable: false,
                indicatorWeight: 3.0,
                labelColor: primaryColor,
                indicatorColor: primaryColor,
                unselectedLabelColor: secondaryColor,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: <Widget>[
                  Tab(
                    // icon: Icon(
                    //   Icons.today,
                    //   color: Colors.green,
                    // ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 7,
                                offset: Offset(1, 10),
                                color: Colors.white.withOpacity(0.2))
                          ]),
                      child: Text(
                        'Withdraw Request',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.font16,
                            fontFamily: 'TiroKannada',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                  Tab(
                    // icon: Icon(
                    //   Icons.assessment,
                    //   color: Colors.green,
                    // ),
                    child: Text(
                      'Withdraw Data',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.font16,
                          fontFamily: 'TiroKannada',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              height: 550,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius30),
                  topRight: Radius.circular(Dimensions.radius30),
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(bottom: 30),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width50,
                            top: Dimensions.height50),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 23,
                                  spreadRadius: 0.1,
                                  offset: Offset(1, 2),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: SingleChildScrollView(
                          child: Column(
                            // mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(
                                      right: Dimensions.width20),
                                  padding: EdgeInsets.only(
                                    top: Dimensions.height20,
                                  ),
                                  child: Text("Withdraw request",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'TiroKannada',
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1))),
                              _textInput(
                                  hint: "Enter Amount",
                                  icon: Icons.money,
                                  controller: controller.amountController),
                              SizedBox(
                                height: Dimensions.height50,
                              ),
                              Container(
                                  width: 180,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [Colors.blue, Colors.blue],
                                          end: Alignment.centerLeft,
                                          begin: Alignment.centerRight),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(100),
                                      )),
                                  child: OutlineButton(
                                    child: Text(
                                      "Send Request",
                                      style: TextStyle(
                                          fontSize: Dimensions.font20),
                                    ),
                                    highlightedBorderColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.font16)),
                                    onPressed: () {
                                      if (controller
                                          .amountController.text.isEmpty) {
                                        showCustomSnackBar(
                                            'Please Enter Amount',
                                            title: 'Error ');
                                      } else {
                                        EasyLoading.show(status: "Saving...");
                                        controller.requestwithdraw();
                                        // clearTextField();
                                      }
                                    },
                                  ))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GetBuilder<WithdrawController>(builder: (withdrawList) {
              return ListView.separated(
                padding: EdgeInsets.all(Dimensions.height30),
                itemCount: withdrawList.withdrawList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildArticleItem(index);
                },
                separatorBuilder: (context, index) =>
                    SizedBox(height: Dimensions.height20),
              );
            }),
          ],
        ),
      ),
    ),
  );
}

Widget _textInput({controller, hint, icon}) {
  return Container(
    margin: EdgeInsets.only(
        top: Dimensions.height20,
        left: Dimensions.width20,
        right: Dimensions.width20),
    width: double.infinity,
    height: 40,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius30),
        boxShadow: [
          BoxShadow(
              blurRadius: 12,
              spreadRadius: 5,
              offset: Offset(1, 10),
              color: Colors.grey.withOpacity(0.2))
        ]),
    padding: EdgeInsets.only(left: 10),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        prefixIcon: Icon(icon),
      ),
    ),
  );
}

Widget _buildArticleItem(int index) {
  final Color primaryColor = Color(0xffFD6592);
  final Color bgColor = Color(0xffF9E0E3);
  final Color secondaryColor = Color(0xff324558);
  final String sample = images[2];
  final f = new DateFormat.yMd();
  return Container(
    color: Colors.white,
    child: GetBuilder<WithdrawController>(builder: (withdrawList) {
      return Stack(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            color: bgColor,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(Dimensions.height15),
            margin: EdgeInsets.all(Dimensions.height15),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            "Amount",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width20,
                          ),
                          Text(
                            withdrawList.withdrawList[index].amount +
                                "  " +
                                "Birr",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: const SizedBox(width: 5.0),
                            ),
                            WidgetSpan(
                              child: const SizedBox(width: 20.0),
                            ),
                            TextSpan(
                              text: f
                                  .format(withdrawList
                                      .withdrawList[index].createdAt)
                                  .toString(),
                            ),
                            WidgetSpan(
                              child: SizedBox(width: Dimensions.width50 * 2),
                            ),
                            WidgetSpan(
                              child: CircleAvatar(
                                radius: 10.0,
                                backgroundColor: primaryColor,
                              ),
                            ),
                            WidgetSpan(
                              child: const SizedBox(width: 10.0),
                            ),
                            TextSpan(
                                text: withdrawList.withdrawList[index].status,
                                style: TextStyle(fontSize: 16.0)),
                          ],
                        ),
                        style: TextStyle(height: 2.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );
    }),
  );
}
