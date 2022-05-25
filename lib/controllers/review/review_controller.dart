import 'package:get/get.dart';
import 'package:service_provider/data/repository/review/review_repo.dart';
import 'package:service_provider/models/review/review_model.dart';

class ReviewController extends GetxController {
  final ReviewRepo reviewRepo;
  bool _isLoad = false;
  bool get isLoad => _isLoad;

  ReviewController({required this.reviewRepo});

  List<dynamic> _review  = [];
  List<dynamic> get reviewList => _review;

  Future<void> getReviewList() async {
    Response response = await reviewRepo.getReviewList();

    try {
      if (response.statusCode == 200) {
        _review = [];
        _review.addAll(Review.fromJson(response.body).review);
        _isLoad = true;
        update();
        //like setstate
      }
    } catch (e) {
      print(e);
    }
  }
}
