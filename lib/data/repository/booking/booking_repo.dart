import 'package:get/get.dart';
import 'package:service_provider/data/api/api_client.dart';
import 'package:service_provider/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

//it took to the api client used to featch data
//it should accesss the api client because we call method in the api client
class BookingRepo extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  BookingRepo({required this.apiClient, required this.sharedPreferences});

//Today ALL bOOKING
  Future<Response> getTodayAllBookingList() async {
    return await apiClient
        .getTodayALLBookingData(AppConstants.TODAY_ALL_BOOKING_URI);
  }
  
  //Today To Be Done Booking
  Future<Response> getTodayCompletedBookingList() async {
    return await apiClient
        .getTodayCompletedBookingData(AppConstants.TODAY_COMPLETED_BOOKING_URI);
  }

  //Today Completed Booking
  Future<Response> getTodayToBeDoneBookingList() async {
    return await apiClient
        .getTodayToBeDoneBookingData(AppConstants.TODAY_TO_BE_DONE_BOOKING_URI);
  }


  //General ALL bOOKING
  Future<Response> getGeneralAllBookingList() async {
    return await apiClient
        .getGeneralALLBookingData(AppConstants.GENERAL_ALL_BOOKING_URI);
  }

  //Geneneal To be done booking

  Future<Response> getGeneralToBeDoneBooking() async {
 
    return await apiClient.getGeneralToBeDoneBookingData(AppConstants.GENERAL_TO_BE_DONE_BOOKING_URI);
  }
  

  //Geneneal To Completed Booking

  Future<Response> getGeneralCompletedBooking() async {
    
    return await apiClient.getGeneralCompletedBookingData(
        AppConstants.GENERAL_COMPLETED_BOOKING_URI);
  }
}
