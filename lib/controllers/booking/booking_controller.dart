import 'package:get/get.dart';
import 'package:service_provider/data/repository/booking/booking_repo.dart';

import 'package:service_provider/models/booking/booking_model.dart';

class BookingController extends GetxController {
  final BookingRepo bookingRepo;

  bool _isLoad = false;
  bool get isLoad => _isLoad;

  BookingController({required this.bookingRepo});
//To get Today ALL Booking
  List<dynamic> _todayAllBooking = [];
  List<dynamic> get todayAllBookingList => _todayAllBooking;

  Future<void> gettodayAllBookingList() async {
    Response response = await bookingRepo.getTodayAllBookingList();

    try {
      if (response.statusCode == 200) {
        _todayAllBooking = [];
        _todayAllBooking.addAll(Booking.fromJson(response.body).data);

        _isLoad = true;
        update();
        //like setstate
      }
    } catch (e) {
      print(e.toString());
    }
  }

//To get Today To Be Done Booking
  List<dynamic> _todayCompletedBooking = [];
  List<dynamic> get todayCompletedBookingList => _todayCompletedBooking;

  Future<void> gettodayCompletedBookingList() async {
    Response response = await bookingRepo.getTodayCompletedBookingList();

    try {
      if (response.statusCode == 200) {
        _todayCompletedBooking = [];
        _todayCompletedBooking.addAll(Booking.fromJson(response.body).data);

        _isLoad = true;
        update();
      }
    } catch (e) {
      print(e.toString());
    }
  }

//To get Today completed
  List<dynamic> _todayToBeDoneBooking = [];
  List<dynamic> get todayToBeDoneBookingList => _todayToBeDoneBooking;

  Future<void> gettodayToBeDoneBookingList() async {
    Response response = await bookingRepo.getTodayToBeDoneBookingList();

    try {
      if (response.statusCode == 200) {
        _todayToBeDoneBooking = [];
        _todayToBeDoneBooking.addAll(Booking.fromJson(response.body).data);

        _isLoad = true;
        update();
        //like setstate
      }
    } catch (e) {
      print(e.toString());
    }
  }

//TO GET General ALL Booking
  List<dynamic> _generalAllBooking = [];
  List<dynamic> get generalAllBookingList => _generalAllBooking;

  Future<void> getgeneralAllBookingList() async {
    Response response = await bookingRepo.getGeneralAllBookingList();

    try {
      if (response.statusCode == 200) {
        _generalAllBooking = [];
        _generalAllBooking.addAll(Booking.fromJson(response.body).data);
        
        _isLoad = true;
        update();
        //like setstate
      }
    } catch (e) {
      print("booking");
    }
  }

//TO GET General tO Be Done  Booking
  List<dynamic> _gToBeDoneBooking = [];
  List<dynamic> get gToBeDoneBooking => _gToBeDoneBooking;

  Future<void> getGeneralToBeDoneBooking() async {
    Response response = await bookingRepo.getGeneralToBeDoneBooking();

    try {
      if (response.statusCode == 200) {
        _gToBeDoneBooking = [];
        _gToBeDoneBooking.addAll(Booking.fromJson(response.body).data);

        _isLoad = true;
        update();
        //like setstate
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //TO GET General Completed Booking
  List<dynamic> _gCompletedBooking = [];
  List<dynamic> get gCompletedBooking => _gCompletedBooking;

  Future<void> getGeneralCompletedBooking() async {
    Response response = await bookingRepo.getGeneralCompletedBooking();

    try {
      if (response.statusCode == 200) {
        _gCompletedBooking = [];
        _gCompletedBooking.addAll(Booking.fromJson(response.body).data);

        _isLoad = true;
        update();
        //like setstate
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
