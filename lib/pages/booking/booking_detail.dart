import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:dio/dio.dart';
import 'package:service_provider/base/custom_loader.dart';
import 'package:service_provider/controllers/booking/booking_controller.dart';
import 'package:service_provider/controllers/service/popular_service_controller.dart';
import 'package:service_provider/routes/route_helper.dart';
import 'package:service_provider/utils/app_constants.dart';
import 'package:service_provider/utils/dimensions.dart';
import 'package:service_provider/widgets/app_icon.dart';
import 'package:service_provider/widgets/big_text.dart';
import 'package:service_provider/widgets/button.dart';
import 'package:service_provider/widgets/expandable_text_widget.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:service_provider/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BookingDetail extends StatelessWidget {
  String _scanBarcode = '';

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    // if (!mounted) return;

    _scanBarcode = barcodeScanRes;

    print(_scanBarcode);
  }

  Future<void> sendScanData(String id) async {
    print(id);
    String token = '';
    SharedPreferences pre = await SharedPreferences.getInstance();
    token = pre.getString(AppConstants.TOKEN) ?? "None token";

    String code = _scanBarcode;

    Dio.Dio dio = new Dio.Dio();
    Dio.FormData formData = new Dio.FormData.fromMap({
      "approval_token": code,
    });
    final String endPoint =
        "https://gcproject.awraticket.com/service_provider/approve_service/" +
            id;
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.post(endPoint, data: formData).then((response) {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        EasyLoading.dismiss();
        Get.snackbar(
          "Success",
          "Send Successfully",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
          margin: EdgeInsets.all(15),
          forwardAnimationCurve: Curves.bounceOut,
        );
      } else {
        EasyLoading.dismiss();
      }
      // ignore: invalid_return_type_for_catch_error
    });
  }

  @override
  Widget build(BuildContext context) {
    final f = new DateFormat.yMd();
    return Scaffold(
      backgroundColor: Colors.white,
      //food description
      body: GetBuilder<BookingController>(builder: (generalAll) {
        return generalAll.isLoad
            ? ListView.builder(
                physics:
                    AlwaysScrollableScrollPhysics(), //the whole page is scrollable but using alwaysscrolla
                shrinkWrap: true,
                itemCount: generalAll.generalAllBookingList.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: Dimensions.height50 * 3,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 23,
                              spreadRadius: 7,
                              offset: Offset(1, 10),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    margin: EdgeInsets.only(
                        top: Dimensions.height50,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: Dimensions.height10),
                    child: Wrap(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(left: Dimensions.width10),
                              child: Center(
                                child: CircleAvatar(
                                  radius: Dimensions.radius30,
                                  backgroundImage: NetworkImage(generalAll
                                      .generalAllBookingList[index]
                                      .user
                                      .profilePicture),
                                ),
                              ),
                            ),
                            //TExT container

                            Expanded(
                              // to allow the width to take all the available width

                              child: Container(
                                height: Dimensions.ListViewTextSize,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: Dimensions.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                        text: generalAll
                                            .generalAllBookingList[index]
                                            .user
                                            .name,
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text(
                                              "Service Type : ",
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                              ),
                                            ),
                                            SizedBox(
                                              width: Dimensions.width20,
                                            ),
                                            Text(
                                              generalAll
                                                  .generalAllBookingList[index]
                                                  .service
                                                  .name,
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Wrap(children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Price : ",
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: Dimensions
                                            //       .width10,
                                            // ),
                                            Text(
                                              generalAll
                                                  .generalAllBookingList[index]
                                                  .service
                                                  .price,
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Expanded(
                                        child: Wrap(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.calendar_today_rounded,
                                                  color: Colors.blue,
                                                  size: Dimensions.font16,
                                                ),
                                                SizedBox(
                                                    width: Dimensions.width10),
                                                Text(
                                                  f.format(generalAll
                                                      .generalAllBookingList[
                                                          index]
                                                      .user
                                                      .createdAt),
                                                ),
                                                SizedBox(
                                                  width: Dimensions.width20 * 5,
                                                ),
                                                ButtonWidget(
                                                  text: 'Save',
                                                  onClicked: () => sendScanData(
                                                    generalAll
                                                        .generalAllBookingList[
                                                            index]
                                                        .id,
                                                  ),
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      scanBarcodeNormal();
                                                      sendScanData(
                                                        generalAll
                                                            .generalAllBookingList[
                                                                index]
                                                            .id,
                                                      );
                                                    },
                                                    child: Container(
                                                      height:
                                                          Dimensions.height30,
                                                      width:
                                                          Dimensions.width20 *
                                                              4,
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimensions
                                                                      .radius30),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                blurRadius: 7,
                                                                spreadRadius: 7,
                                                                offset: Offset(
                                                                    1, 5),
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2))
                                                          ]),
                                                      child: Center(
                                                        child: Text(
                                                          "Scan",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Dimensions
                                                                      .font20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                })
            : CustomLoader();
      }),
    );
  }
}
