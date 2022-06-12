import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_provider/base/show_custom_snackbar.dart';
import 'package:service_provider/data/repository/service/popular_service_repo.dart';
import 'package:service_provider/models/service/service_model.dart';
import 'dart:io';
import 'package:dio/dio.dart' as Dio;
import 'package:service_provider/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class PopularServiceController extends GetxController {
  final PopularServiceRepo popularServiceRepo; //instance of repo
  var isLogoPathSet = false.obs;
  var logoPath = "".obs;
  var isLogoPathSett = false.obs;
  var logoPathh = "".obs;
  var selectedType = 1.obs;
  //boolean for loading

  bool _isLoad = false;
  bool get isLoad => _isLoad;
  //main service page
  bool _isLoading = false;
  bool get isLoading => _isLoading;

//for image pick
  void setPath(String path) {
    logoPath.value = path;
    isLogoPathSet.value = true;
    //for edit service
    logoPathh.value = path;
    isLogoPathSett.value = true;
  }

  //for drop down

  PopularServiceController({required this.popularServiceRepo});
// _popularServiceList  this one is list name data got from the popular_Service_repo
  List<dynamic> _popularServiceList = [];

//_popularServiceList is gooten using below method and to acess it from any class it must be
//public so to make it public(but in this type it is private contain _ ) we use the below list method
  List<dynamic> get popularServiceList => _popularServiceList;

// getPopularServiceList=>method found in the repository
  Future<void> getPopularServiceList() async {
    // _isLoad= true;
// we write Response because repo return Response i.e Future<Response>
    Response response = await popularServiceRepo
        .getPopularServiceList(); //calling method found in repo that contain data fetched from the api client

    try {
      if (response.statusCode == 200) {
        _popularServiceList = []; //intialize to null to avoid data repition

        _popularServiceList.addAll(Service.fromJson(response.body)
            .services); //change Json type data change in to a model

        _isLoad = true;
        update();
        //like setstate
      }
    } catch (e) {
      print(e);
    }
  }

  //For Add service

  final String endPoint =
      "https://gcproject.awraticket.com/service_provider/add_service";
  late File imageFile;

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
    } else if (pickedImage == null) {
      showCustomSnackBar('Select Your Logo', title: 'Error');
    }

    setPath(imageFile.path);
  }

//Add services
  Dio.Dio dio = new Dio.Dio();

  Future<void> addServices() async {
    String token = '';
    SharedPreferences pre = await SharedPreferences.getInstance();
    token = pre.getString(AppConstants.TOKEN) ?? "None token";

    String name = nameController.text.trim();
    String description = descriptionController.text.trim();
    String prise = priseController.text.trim();
    String type = selectedType.value.toString();
    print(imageFile.path.isEmpty);

    String filename = imageFile.path.split('/').last;
    Dio.FormData formData = new Dio.FormData.fromMap({
      "name": name,
      "description": description,
      "price": prise,
      "type": type,
      "image": await Dio.MultipartFile.fromFile(imageFile.path,
          filename: filename, contentType: new MediaType("image", "jpg")),
    });
    if (imageFile.path.isEmpty) {
      print("empty");
    }
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.post(endPoint, data: formData).then((response) {
      if (response.statusCode == 201) {
        EasyLoading.dismiss();
        getPopularServiceList();
        EasyLoading.dismiss();
        Get.snackbar(
          "Success",
          "Service Added Successfully",
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
}
