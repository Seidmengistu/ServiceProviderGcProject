import 'dart:io';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:service_provider/base/show_custom_snackbar.dart';
import 'package:service_provider/controllers/service/popular_service_controller.dart';
import 'package:service_provider/pages/services/home_page.dart';

import 'package:service_provider/pages/services/main_service_page.dart';

import 'package:service_provider/utils/app_constants.dart';
import 'package:service_provider/utils/dimensions.dart';

import 'package:service_provider/widgets/app_icon.dart';

import 'package:service_provider/widgets/big_text.dart';
import 'package:service_provider/widgets/expandable_text_widget.dart';

import 'package:service_provider/widgets/icon_text_widget_detail.dart';
import 'package:service_provider/widgets/small_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:service_provider/widgets/res/assets.dart';
import 'package:service_provider/widgets/res/network_image.dart';

//159|QOk8caiwBN4rVNgfylLGuk0oxi0ULYzZ9pFMDcja
class PopularServiceDetail extends StatefulWidget {
  final int pageId;
  const PopularServiceDetail({Key? key, required this.pageId})
      : super(key: key);

  @override
  State<PopularServiceDetail> createState() => _PopularServiceDetailState();
}

class _PopularServiceDetailState extends State<PopularServiceDetail> {
  late File imageFile;

  @override
  Widget build(BuildContext context) {
    controller.getPopularServiceList();
    Get.find<PopularServiceController>().getPopularServiceList();
    //to get page id
    var service =
        Get.find<PopularServiceController>().popularServiceList[widget.pageId];
    nameController.text = service.name;
    descriptionController.text = service.description;
    typeController.text = service.type.toString();
    priseController.text = service.price.toString();

    return Scaffold(
      body: Stack(
        children: [
          //back ground image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.PopularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        service.image!,
                  ),
                ),
              ),
            ),
          ),
          //showing icons widget
          Positioned(
            top: Dimensions.height50,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => SHomePage(selectedIndex: 1), arguments: 1);
                    // pushNewScreen(
                    //   context,
                    //   screen: SHomePage(),
                    //   withNavBar: false, // OPTIONAL VALUE. True by default.
                    //   pageTransitionAnimation:
                    //       PageTransitionAnimation.cupertino,
                    // );
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios),
                ),
                // AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
          ),
          //introduction of foood
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.PopularFoodImgSize - 20, //to show the border
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: service.name,
                    size: Dimensions.font26,
                  ),
                  SizedBox(
                      height: Dimensions
                          .height10), //put space between text and star
                  Row(
                    children: [
                      Wrap(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            color: Colors.lightGreen,
                            size: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SmallText(text: "4.5"),
                      SizedBox(width: 10),
                      SmallText(text: "1287"),
                      SizedBox(width: 10),
                      SmallText(text: "comments"),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconAndTextWidgett(
                        icon: Icons.circle_sharp,
                        text: "Normal",
                        iconColor: Colors.orangeAccent,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      IconAndTextWidgett(
                        icon: Icons.money,
                        text: ("\$ ${service.price!}"),
                        iconColor: Colors.lightBlue,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      IconAndTextWidgett(
                        icon: Icons.access_time_rounded,
                        text: "32 min",
                        iconColor: Colors.red,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  BigText(text: "Service Description"),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(text: service.description!),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.height10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.height10,
                              bottom: Dimensions.height20,
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            // color: Colors.black12,
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  // SizedBox(
                                  //   width: Dimensions.width30,
                                  // ),
                                  SizedBox(
                                    height: Dimensions.height30,
                                  ),
                                  FloatingActionButton.extended(
                                    heroTag: "btn1",
                                    label: Text("Edit"),
                                    icon: Icon(Icons.edit),
                                    hoverColor: Colors.green[800],
                                    onPressed: () {
                                      diaplayAddServiceWindow();
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              // top: Dimensions.height10,
                              bottom: Dimensions.height20,
                              left: Dimensions.width50,
                              right: Dimensions.width50),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            // color: Colors.lightBlueAccent,
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: Dimensions.height30,
                                  ),
                                  FloatingActionButton.extended(
                                    heroTag: "btn2",
                                    label: Text("Delete"),
                                    icon: Icon(Icons.delete),
                                    hoverColor: Colors.red[800],
                                    backgroundColor: Colors.red,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return deleteAlert(context);
                                        },
                                      );
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          //expandable text widget
        ],
      ),
    );
  }

  //bottom sheet
  void diaplayAddServiceWindow() {
    var service =
        Get.find<PopularServiceController>().popularServiceList[widget.pageId];

    Get.bottomSheet(
      Container(
        height: 800,
        margin: EdgeInsets.only(
            left: Dimensions.height10, right: Dimensions.height10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius20),
              topLeft: Radius.circular(Dimensions.radius20),
            ),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 7,
                  offset: Offset(1, 10),
                  color: Colors.blue.withOpacity(0.2))
            ]),
        child: Padding(
          padding: EdgeInsets.only(
              left: Dimensions.width15,
              right: Dimensions.width15,
              top: Dimensions.height15),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Edit Services",
                      style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                          decorationColor: Colors.blue),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Obx(
                    () => Center(
                      child: CircleAvatar(
                        // ignore: unrelated_type_equality_checks
                        backgroundImage: controller.isLogoPathSett == true
                            ? FileImage(File(controller.logoPathh.value))
                                as ImageProvider
                            : AssetImage("assets/l2.png"),
                        radius: Dimensions.radius20 * 4,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.height20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1, 10),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    child: FlatButton.icon(
                      minWidth: double.infinity,
                      onPressed: () {
                        Get.dialog(bottomSheet(context));
                      },
                      icon: Icon(
                        Icons.image_rounded,
                        color: Colors.blue,
                      ),
                      label: Text(
                        "Add Image",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.height20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1, 10),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    child: TextFormField(
                      // initialValue: service.name,

                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: "Name",
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Colors.blue,
                            ),
                          ),

                          //enabled boredr
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.grey,
                              )),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.white,
                              ))),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.height20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1, 10),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    child: TextFormField(
                      controller: descriptionController,
                      // initialValue: service.description,
                      decoration: InputDecoration(
                          labelText: "Description",
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Colors.blue,
                            ),
                          ),

                          //enabled boredr
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.grey,
                              )),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.white,
                              ))),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height15,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.height20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1, 10),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: priseController,
                      // initialValue: service.price.toString(),
                      decoration: InputDecoration(
                          labelText: "Price",
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Colors.blue,
                            ),
                          ),

                          //enabled boredr
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.grey,
                              )),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.white,
                              ))),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height15,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.height20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1, 10),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    child: Obx(
                      () => DropdownButtonFormField<String>(
                        decoration: InputDecoration(),
                        items: [
                          DropdownMenuItem(
                            value: "1",
                            child: Text(
                              "Salon",
                              style: TextStyle(
                                fontSize: Dimensions.font20,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "2",
                            child: Text(
                              "Spa",
                              style: TextStyle(
                                fontSize: Dimensions.font20,
                              ),
                            ),
                          ),
                        ],
                        value: controller.selectedType.value.toString(),
                        isExpanded: true,
                        onChanged: (selectedValue) {
                          controller.selectedType.value =
                              int.parse(selectedValue!);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Center(
                    child: FloatingActionButton.extended(
                      label: Text("Update"),
                      icon: Icon(Icons.add),
                      onPressed: () {
                        if (nameController.text.isEmpty) {
                          showCustomSnackBar('Type in your  name',
                              title: 'Error ');
                        } else if (descriptionController.text.isEmpty) {
                          showCustomSnackBar('Type in your  description',
                              title: 'Error');
                        } else if (priseController.text.isEmpty) {
                          showCustomSnackBar('Type in your  prise',
                              title: 'Prise');
                        } else if (!priseController.text.isNum) {
                          showCustomSnackBar('Price must be a number',
                              title: 'prise');
                        } else {
                          EasyLoading.show(status: "Updating");
                          _updateServices(service.id.toString());
                        }
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

// To Select Image
  Widget bottomSheet(BuildContext context) {
    return Center(
      child: Dialog(
        elevation: 3,
        backgroundColor: Colors.transparent,
        child: Container(
          // padding: EdgeInsets.only(
          //   right: 16.0,
          // ),
          height: Dimensions.height50 * 3,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75),
                  bottomLeft: Radius.circular(75),
                  topRight: Radius.circular(75),
                  bottomRight: Radius.circular(75))),
          child: Column(
            children: [
              BigText(text: "Choose Image"),
              SizedBox(height: Dimensions.height20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      chooseImage(ImageSource.gallery);
                      Get.back();
                      // Navigator.pop(context, bottomSheet(context));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Text(
                          "Gallery",
                          style: TextStyle(
                            // color: Colors.blue,
                            fontSize: Dimensions.font20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width20 * 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      chooseImage(ImageSource.camera);
                      Get.back();
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Text(
                          "Camera",
                          style: TextStyle(
                            // color: Colors.blue,
                            fontSize: Dimensions.font20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  //To delete Service
  Future<void> _delete(String id) async {
    print(id);
    final String endPoint =
        "http://www.gcproject.awraticket.com/service_provider/delete_service/" +
            id;
    // print(endPoint);
    String token = '';
    SharedPreferences pre = await SharedPreferences.getInstance();
    token = pre.getString(AppConstants.TOKEN) ?? "None token";
    // print(token);
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.get(endPoint).then((response) {
      print(response.data);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        controller.getPopularServiceList();
        Get.back();
        Get.snackbar(
          "Success",
          "Service Deleted Successfully",
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

  var controller = Get.find<PopularServiceController>();
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priseController = TextEditingController();
  var typeController = TextEditingController();

  // choose image
  ImagePicker picker = ImagePicker();
  Future<void> chooseImage(ImageSource source) async {
    final pickedImage =
        // ignore: deprecated_member_use
        await picker.getImage(source: source, imageQuality: 100);
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
    } else {
      showCustomSnackBar('Select Your Logo', title: 'Error');
    }
  }

//update services
  Dio.Dio dio = new Dio.Dio();
  Future<void> _updateServices(String id) async {
    print(id);
    final String endPoint =
        "http://www.gcproject.awraticket.com/service_provider/edit_service/" +
            id;

    String token = '';
    SharedPreferences pre = await SharedPreferences.getInstance();
    token = pre.getString(AppConstants.TOKEN) ?? "None token";

    String name = nameController.text.trim();
    String description = descriptionController.text.trim();
    String prise = priseController.text.trim();
    String type = controller.selectedType.value.toString();
    // print("edited name is" + name);

    String filename = imageFile.path.split('/').last;
    print(filename);
    Dio.FormData formData = new Dio.FormData.fromMap({
      "name": name,
      "description": description,
      "price": prise,
      "type": type,
      "image": await Dio.MultipartFile.fromFile(imageFile.path,
          filename: filename, contentType: new MediaType("image", "jpg")),
    });
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.post(endPoint, data: formData).then((response) {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Get.to(() => MainServiceList());

        Get.snackbar(
          "Success",
          "Service Updated Successfully",
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

//to Delete Services
  Widget deleteAlert(BuildContext context) {
    var service =
        Get.find<PopularServiceController>().popularServiceList[widget.pageId];
    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.only(right: 16.0),
          height: 150,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75),
                  bottomLeft: Radius.circular(75),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              CircleAvatar(
                radius: 55,
                backgroundColor: Colors.grey.shade200,
                child: PNetworkImage(
                  infoIcon,
                  width: 60,
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Alert!",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 10.0),
                    Flexible(
                      child: Text("Do you want to Delete this service?"),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            child: Text("No"),
                            color: Colors.red,
                            colorBrightness: Brightness.dark,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: RaisedButton(
                            child: Text("Yes"),
                            color: Colors.green,
                            colorBrightness: Brightness.dark,
                            onPressed: () {
                              EasyLoading.show(status: "Deleting...");

                              _delete(service.id.toString());

                              Get.back();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
