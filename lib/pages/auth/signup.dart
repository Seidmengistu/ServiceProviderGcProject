// import 'dart:convert';
// import 'dart:convert';
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
// late String token;
  final String endPoint =
      "http://www.gcproject.daguads.com/service_provider/register";
  late double latitude;
  late double longitude;

//for drop down
  final List<String> serviceType = ["1", "2"];
  String selectedType = "1";
//function to pick image
  ImagePicker picker = ImagePicker();
  var authController = Get.find<AuthController>();
  Future<void> chooseImage(ImageSource source) async {
    final pickedImage =
        // ignore: deprecated_member_use
        await picker.getImage(source: source, imageQuality: 100);
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
    } else {
      showCustomSnackBar('Select Your Logo', title: 'Error');
    }
    setState(() {});
    authController.setPath(imageFile.path);
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

  var ownerNameController = TextEditingController();
  var businessNameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Dio.Dio dio = new Dio.Dio();

    Future<void> _registration() async {
      String ownername = ownerNameController.text.trim();
      String businessname = businessNameController.text.trim();
      String phone = phoneController.text.trim();

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
          // ignore: invalid_return_type_for_catch_error
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
                        GestureDetector(
                          child: Icon(Icons.camera),
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => bottomSheet(context));
                          },
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
                        AppTextField(
                          hintText: "Phone Number",
                          icon: Icons.phone,
                          textController: phoneController,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Container(
                          // width: double.infinity,
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
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.room_service,
                                  size: Dimensions.iconSize24,
                                  color: Colors.blue[900],
                                ),
                                SizedBox(
                                  width: Dimensions.width20,
                                ),
                                Text(
                                  "Select Service",
                                  style: TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.width20,
                                ),
                                DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  value: selectedType,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedType = value!;
                                    });
                                  },
                                  items: serviceType
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                ),
                              ],
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
                              color: Colors.blue,
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
                              highlightColor: Colors.blue,
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
                                    "Click Get Current Location",
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
                        // GestureDetector(
                        //   onTap: () {
                        //     getCurrentLocation();
                        //   },
                        //   child: Container(
                        //     margin: EdgeInsets.only(
                        //         left: Dimensions.height20,
                        //         right: Dimensions.height20),
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius:
                        //           BorderRadius.circular(Dimensions.radius30),
                        //       boxShadow: [
                        //         BoxShadow(
                        //             blurRadius: 10,
                        //             spreadRadius: 7,
                        //             offset: Offset(1, 10),
                        //             color: Colors.grey.withOpacity(0.2))
                        //       ],
                        //     ),
                        //     child: Center(
                        //       heightFactor: 2,
                        //       child: BigText(
                        //         text: 'Get Location',
                        //         size: Dimensions.font16 + 4,
                        //         color: Colors.black,
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        GestureDetector(
                          onTap: () {
                            // getCurrentLocation();
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account?"),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => LoginPage());
                          },
                          child: Text(
                            " Login",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        )
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
    return Container(
      // margin: EdgeInsets.symmetric(
      //   vertical: Dimensions.height20,
      //   horizontal: Dimensions.width10,
      // ),
      height: Dimensions.height50 * 3,
      width: double.infinity * 0.4,
      child: Column(
        children: [
          BigText(text: "Choose Logo"),
          SizedBox(height: Dimensions.height20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  chooseImage(ImageSource.gallery);
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
    );
  }
}
