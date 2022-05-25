class Review {
  late List<ReviewModel> _review;
  
  List<ReviewModel> get review => _review;

  
  Review({required review}) {
   
    this._review = review;
  }

  Review.fromJson(Map<String, dynamic> json) {
    if (json['review'] != null) {
      _review = <ReviewModel>[]; 
      json['review'].forEach((v) {
        _review.add(ReviewModel.fromJson(v)); 
      });
    }
  }
}

class ReviewModel {
  int? id;
  int? rate;
  String? review;
  String? userId;
  String? serviceProviderId;
  String? createdAt;
  String? updatedAt;

  ReviewModel(
      {this.id,
      this.rate,
      this.review,
      this.userId,
      this.serviceProviderId,
      this.createdAt,
      this.updatedAt});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rate = json['rate'];
    review = json['review'];
    userId = json['user_id'];
    serviceProviderId = json['service_provider_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
