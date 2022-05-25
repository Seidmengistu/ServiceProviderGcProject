import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:service_provider/controllers/dashboard/dashboard_controller.dart';
import 'package:service_provider/utils/dimensions.dart';
import 'package:service_provider/widgets/big_text.dart';
import 'package:service_provider/widgets/icon_and_text_widget.dart';
import 'package:service_provider/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  final _controller = Get.find<DashboardController>().fetchInformation();
    final _controller = Get.find<DashboardController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(height: Dimensions.height10), //put space between text and star
        Row(
          children: [
            RatingBar.builder(
              itemSize: Dimensions.font16,
              initialRating:
                  double.parse(_controller.dashboardInformation[0].rate),
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
            SizedBox(width: 10),
            SmallText(
              text: _controller.dashboardInformation[0].rate,
            ),
            SizedBox(width: 10),
            SmallText(text: "1287"),
            SizedBox(width: 10),
            SmallText(text: "comments"),
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
              icon: Icons.favorite,
              text: "Rate",
              iconColor: Colors.orangeAccent,
            ),
            SizedBox(
              width: 20,
            ),
            IconAndTextWidget(
              icon: Icons.zoom_out,
              text: _controller.dashboardInformation[0].rate.toString(),
              iconColor: Colors.lightBlue,
            ),
            SizedBox(
              width: 20,
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: "32 smin",
              iconColor: Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}
