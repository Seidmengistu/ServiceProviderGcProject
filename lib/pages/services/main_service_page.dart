import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_provider/base/show_custom_snackbar.dart';
import 'package:service_provider/controllers/service/popular_service_controller.dart';
import 'package:service_provider/pages/services/service_list.dart';

import 'package:service_provider/utils/dimensions.dart';
import 'package:service_provider/widgets/app_text_field.dart';
import 'package:service_provider/widgets/big_text.dart';

class MainServiceList extends StatefulWidget {
  @override
  State<MainServiceList> createState() => _MainServiceListState();
}

class _MainServiceListState extends State<MainServiceList> {
  var controller = Get.find<PopularServiceController>();

  late File imageFile;
  @override
  Widget build(BuildContext context) {
    Get.find<PopularServiceController>().getPopularServiceList();
    EasyLoading.dismiss();
    // print("current height is " + MediaQuery.of(context).size.width.toString());
    return Scaffold(
      body: Column(
        children: [
          //showing the header
          Container(
            height: MediaQuery.of(context).size.height - 630.0,
            decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 10),
                      color: Colors.grey.withOpacity(0.2))
                ]),
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height50 + 10, bottom: Dimensions.height15),
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FloatingActionButton.extended(
                          label: Text("Add Services"),
                          icon: Icon(Icons.add),
                          onPressed: () {
                            diaplayAddServiceWindow();

                            clearTextField();
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          Expanded(
            child: SingleChildScrollView(
              //wrap with expanded because we want the full page scrolable
              child: ServiceList(),
            ),
          ),

          //showing the body
        ],
      ),
    );
  }

//bottom sheet For Add services
  void diaplayAddServiceWindow() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Dimensions.radius30),
            topLeft: Radius.circular(Dimensions.radius30),
          ),
          color: Colors.white,
        ),
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
                      "Add Service",
                      style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'TiroKannada',
                          decorationColor: Colors.blue),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height15,
                  ),
                  Obx(
                    () => Center(
                      child: CircleAvatar(
                        // ignore: unrelated_type_equality_checks
                        backgroundImage: controller.isLogoPathSet == true
                            ? FileImage(File(controller.logoPath.value))
                                as ImageProvider
                            : AssetImage("assets/l2.png"),
                        radius: Dimensions.radius20 * 4,
                      ),
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
                    height: Dimensions.height15,
                  ),
                  AppTextField(
                      hintText: "Add Service Name",
                      icon: Icons.add,
                      textController: controller.nameController),
                  SizedBox(
                    height: Dimensions.height15,
                  ),
                  AppTextField(
                      hintText: "Add Descrioption",
                      icon: Icons.description,
                      textController: controller.descriptionController),
                  SizedBox(
                    height: Dimensions.height15,
                  ),
                  AppTextField(
                      hintText: "Add price",
                      icon: Icons.price_check,
                      textController: controller.priseController),
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
                              "Men",
                              style: TextStyle(
                                fontSize: Dimensions.font20,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "2",
                            child: Text(
                              "Women",
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
                    height: Dimensions.height20,
                  ),
                  Center(
                    child: FloatingActionButton.extended(
                      label: Text("Add Service"),
                      icon: Icon(Icons.add),
                      onPressed: () {
                        if (controller.nameController.text.isEmpty) {
                          showCustomSnackBar('Type in your  name',
                              title: 'Error ');
                        } else if (controller
                            .descriptionController.text.isEmpty) {
                          showCustomSnackBar('Type in your  description',
                              title: 'Error');
                        } else if (controller.priseController.text.isEmpty) {
                          showCustomSnackBar('Type in your  prise',
                              title: 'Prise');
                        } else if (!controller.priseController.text.isNum) {
                          showCustomSnackBar('Price must be a number',
                              title: 'prise');
                        } else if (controller.imageFile.path.isEmpty) {
                          showCustomSnackBar('Please Select Your Image',
                              title: 'Image');
                        } else {
                          EasyLoading.show(status: "Saving...");
                          controller.addServices();

                          Get.back();
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
                          controller.chooseImage(ImageSource.gallery);
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
                          controller.chooseImage(ImageSource.camera);
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

      void clearTextField() {
        controller.nameController.clear();
        controller.typeController.clear();
        controller.descriptionController.clear();
        controller.priseController.clear();
      }
}
