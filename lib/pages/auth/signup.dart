import 'dart:io';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:service_provider/base/show_custom_snackbar.dart';
import 'package:service_provider/controllers/auth_controller.dart';

import 'package:service_provider/pages/auth/login.dart';
import 'package:service_provider/pages/auth/otp.dart';
import 'package:service_provider/utils/app_constants.dart';
import 'package:service_provider/utils/dimensions.dart';
import 'package:service_provider/widgets/app_text_field.dart';
import 'package:service_provider/widgets/big_text.dart';
import 'package:service_provider/widgets/header_widget.dart';
import 'package:http_parser/http_parser.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late File imageFile;
  late var phone = Get.arguments;
  var authController = Get.find<AuthController>();
// late String token;
  final String endPoint =
      "https://gcproject.awraticket.com/service_provider/register";
  //  final String endPoint =AppConstants.BASE_URL+AppConstants.REGISTRATION_URI;
  late double latitude;
  late double longitude;

//for drop down
  final List<String> serviceType = ["1", "2"];
  String selectedType = "1";
//function to pick image

  ImagePicker picker = ImagePicker();
  Future<void> chooseImage(ImageSource source) async {
    final pickedImage =
        // ignore: deprecated_member_use
        await picker.getImage(source: source, imageQuality: 100);
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
    } else if (pickedImage == null) {
      showCustomSnackBar('Select Your Logo', title: 'Error');
    }

    authController.setPath(imageFile.path);
  }

  var ownerNameController = TextEditingController();
  var businessNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Dio.Dio dio = new Dio.Dio();

    Future<void> _registration() async {
      String ownername = ownerNameController.text.trim();
      String businessname = businessNameController.text.trim();
      print(imageFile);

      if (ownername.isEmpty) {
        showCustomSnackBar('Type in your  name', title: 'Owner Name ');
      } else if (businessname.isEmpty) {
        showCustomSnackBar('Type in your  phone number',
            title: 'Business Name');
      } else if (phone.isEmpty) {
        showCustomSnackBar('Type in your  phone number', title: 'Phone');
      } else {
        String filename = imageFile.path.split('/').last;
        Dio.FormData formData = new Dio.FormData.fromMap({
          "owner_name": ownername,
          "business_name": businessname,
          "phone_number": phone,
          "type": selectedType,
          "latitude": latitude,
          "longitude": longitude,
          "logo": await Dio.MultipartFile.fromFile(imageFile.path,
              filename: filename, contentType: new MediaType("image", "jpg")),
        });

        print(formData.toString());
        dio
            .post(
          endPoint,
          data: formData,
        )
            .then((response) {
          if (response.statusCode == 201) {
            Get.to(() => Otp(), arguments: phone);
          }
        }).catchError((e) => print(e));
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Stack(children: [
          Container(
            height: Dimensions.height50 * 4,
            child: HeaderWidget(
                Dimensions.height50 * 4, false, Icons.person_add_alt_1_rounded),
          ),
          Container(
            padding: EdgeInsets.only(top: Dimensions.height30 * 3.5),
            height: MediaQuery.of(context).size.height + 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: Dimensions.font26,
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Text(
                          "Create an account, it's free",
                          style: TextStyle(
                              fontSize: Dimensions.font16,
                              color: Colors.grey[700]),
                        ),
                        Obx(
                          () => CircleAvatar(
                            // ignore: unrelated_type_equality_checks
                            backgroundImage: authController.isLogoPathSet ==
                                    true
                                ? FileImage(File(authController.logoPath.value))
                                    as ImageProvider
                                : AssetImage("assets/l2.png"),
                            radius: Dimensions.radius20 * 4,
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.height20),
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
                              // Navigator.pop(context, bottomSheet(context));
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
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        AppTextField(
                          textController: ownerNameController,
                          hintText: "Owner Name",
                          icon: Icons.person,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        AppTextField(
                          hintText: "Business Name",
                          icon: Icons.business,
                          textController: businessNameController,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.height20),
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
                              value:
                                  authController.selectedType.value.toString(),
                              isExpanded: true,
                              onChanged: (selectedValue) {
                                authController.selectedType.value =
                                    int.parse(selectedValue!);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Container(
                          // width: double.infinity,
                          height: Dimensions.height50,
                          margin: EdgeInsets.only(
                              left: Dimensions.height20,
                              right: Dimensions.height20),
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
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(left: Dimensions.width20),
                            child: InkWell(
                              splashColor: Colors.green,
                              highlightColor: Colors.white,
                              onTap: () {
                                getCurrentLocation();
                              },
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: Dimensions.iconSize24,
                                    color: Colors.blue[900],
                                  ),
                                  SizedBox(
                                    width: Dimensions.width20,
                                  ),
                                  Text(
                                    "Click To Access Location",
                                    style: TextStyle(
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        GestureDetector(
                          onTap: () {
                            _registration();
                          },
                          child: Container(
                            width: Dimensions.screenWidth / 2,
                            height: Dimensions.screenHeight / 13,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              color: Colors.blue[500],
                            ),
                            child: Center(
                              child: BigText(
                                text: 'Sign Up',
                                size: Dimensions.font26,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))
              ],
            ),
          ),
        ]),
      ),
    );
  }

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

  //function to get current location
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;

    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }
}
