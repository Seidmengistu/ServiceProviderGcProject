import 'package:get/get.dart';
import 'package:service_provider/data/api/api_client.dart';
import 'package:service_provider/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

//it took to the api client used to featch data
//it should accesss the api client because we call method in the api client
class ReviewRepo extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ReviewRepo(
      {required this.apiClient, required this.sharedPreferences});

//getPopularProductList is the method name
  Future<Response> getReviewList() async {
    return await apiClient.getReviewData(AppConstants.Review_URI); //pass end point url  getData is method name found in the repo
  }
}
