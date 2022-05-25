class DashboardModel {
  String rate;
  int? totalBooking;
  int? todayTotalBooking;
  double? totalBalance;

  DashboardModel(
      {required this.rate,
      this.totalBooking,
      this.todayTotalBooking,
      this.totalBalance});

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      rate: double.tryParse(json['rate']).toString(),
      todayTotalBooking: json['today_total_booking'],
      totalBooking: json['total_booking'],
      totalBalance: json['total_balance'],
    );
  }
}
