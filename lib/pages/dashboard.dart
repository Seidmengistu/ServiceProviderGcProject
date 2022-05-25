import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:service_provider/controllers/dashboard/dashboard_controller.dart';
import 'package:service_provider/pages/test.dart';
import 'package:service_provider/utils/dimensions.dart';
import 'package:service_provider/widgets/app_icon.dart';
import 'package:service_provider/widgets/res/assets.dart';

class Dashboard extends StatelessWidget {
  final String avatar = avatars[0];
  final TextStyle whiteText = TextStyle(color: Colors.white);
  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    final _controller = Get.find<DashboardController>().fetchInformation();
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final _controller = Get.find<DashboardController>();
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(),
            SizedBox(height: Dimensions.height50),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
            ),
            SizedBox(height: Dimensions.height50),
            Card(
              elevation: 10.0,
              color: Colors.white,
              margin: EdgeInsets.all(Dimensions.width10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: [
                        RatingBar.builder(
                          itemSize: Dimensions.font26,
                          initialRating: double.parse(
                              _controller.dashboardInformation[0].rate),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        ListTile(
                          leading: Container(
                            padding: EdgeInsets.only(
                                left: Dimensions.width15,
                                top: Dimensions.height10 - 5),
                            width: 12.0,
                            child: Icon(
                              Icons.rate_review,
                              color: Colors.blue,
                            ),
                          ),
                          style: ListTileStyle.list,
                          title: Text("Rate"),
                          subtitle:
                              Text(_controller.dashboardInformation[0].rate),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                    child: ListTile(
                      leading: Container(
                        padding: EdgeInsets.only(top: Dimensions.height10 - 5),
                        child: Icon(
                          Icons.book_online,
                          color: Colors.blue,
                        ),
                      ),
                      title: Text("Total Booking"),
                      subtitle: Text(_controller
                          .dashboardInformation[0].totalBooking
                          .toString()),
                    ),
                  ),
                ],
              ),
            ),
            // ),
            SizedBox(height: Dimensions.height50 + 50),
            Card(
              elevation: 10.0,
              color: Colors.white,
              // margin: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      leading: Container(
                        padding: EdgeInsets.only(top: Dimensions.height10 - 5),
                        child: Icon(
                          Icons.today_rounded,
                          color: Colors.blue,
                        ),
                      ),
                      title: Text(
                        "Today Total Booking",
                        textAlign: TextAlign.start,
                      ),
                      subtitle: Text(
                        _controller.dashboardInformation[0].todayTotalBooking
                            .toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.font16,
                            fontFamily: "new times Roman"),
                      ),
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                    child: ListTile(
                      leading: Container(
                        padding: EdgeInsets.only(top: Dimensions.height10 - 5),
                        child: Icon(
                          Icons.account_balance_rounded,
                          color: Colors.blue,
                        ),
                      ),
                      title: Text("Total Balance"),
                      subtitle: Text(
                        _controller.dashboardInformation[0].totalBalance
                                .toString() +
                            " " +
                            "Birr",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.font16,
                            fontFamily: "new times Roman"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 32.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        color: Colors.blue[300],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              "Home",
              style: whiteText.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            trailing: CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(avatar),
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Service provider",
              style: whiteText.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Service Name",
              style: whiteText,
            ),
          ),
        ],
      ),
    );
  }
}
