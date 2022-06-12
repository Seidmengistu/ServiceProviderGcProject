import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:service_provider/base/custom_loader.dart';
import 'package:service_provider/controllers/booking/booking_controller.dart';
import 'package:service_provider/controllers/profile/profile_controller.dart';
import 'package:service_provider/controllers/review/review_controller.dart';
import 'package:service_provider/models/booking/booking_model.dart';
import 'package:service_provider/utils/app_constants.dart';
import 'package:service_provider/utils/dimensions.dart';
import 'package:service_provider/widgets/app_icon.dart';
import 'package:service_provider/widgets/big_text.dart';
import 'package:service_provider/widgets/expandable_text_widget.dart';
import 'package:service_provider/widgets/res/assets.dart';

class ReportList extends StatefulWidget {
  const ReportList({Key? key}) : super(key: key);
  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  final String avatar = avatars[0];
  Widget build(BuildContext context) {
    Get.find<ReviewController>().getReviewList();

    final _profileInfo = Get.find<ProfileController>();
    final f = new DateFormat.yMd();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: Dimensions.height50 + 70,
          // centerTitle: true,
          flexibleSpace: Container(
            padding: EdgeInsets.only(top: Dimensions.height50 + 55),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimensions.radius30 + 50),
                    bottomRight: Radius.circular(Dimensions.radius30 + 50)),
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blue],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
            child: Column(
              children: [
                TabBar(
                  isScrollable: false,
                  indicatorColor: Colors.amberAccent,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(
                      // text: 'Review',
                      child: Text(
                        'Review',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.font16,
                            fontFamily: 'TiroKannada',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Payment',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.font16,
                            fontFamily: 'TiroKannada',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Withdraw',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.font16,
                            fontFamily: 'Roboto',
                            letterSpacing: 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Container(
          //    Wrap(
          // children: <Widget>Column);
          child: TabBarView(
            children: [
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GetBuilder<ReviewController>(builder: (reviewList) {
                      return Container(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: Dimensions.radius30 * 2,
                              backgroundImage: NetworkImage(AppConstants
                                      .BASE_URL +
                                  AppConstants.UPLOAD_URL +
                                  _profileInfo.profileInfo[0].logo.toString()),
                            ),
                            SizedBox(
                              height: Dimensions.height15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  itemSize: Dimensions.font26,
                                  initialRating: double.tryParse(
                                          reviewList.reviewList[0].rate)!
                                      .toDouble(),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                                SizedBox(
                                  width: Dimensions.width15,
                                ),
                                Text(
                                  reviewList.reviewList[0].rate + " " + "/ 5",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.font16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(
                      height: Dimensions.height15,
                    ),
                    Container(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showMaterialModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                elevation: 4,
                                builder: (context) => Container(
                                  height: MediaQuery.of(context).size.height -
                                      180.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius30),
                                  ),
                                  child: GetBuilder<ReviewController>(
                                      builder: (reviewList) {
                                    return reviewList.isLoad
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                reviewList.reviewList.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                color: Colors.white,
                                                margin: EdgeInsets.only(
                                                  top: Dimensions.height10,
                                                  left: Dimensions.width20,
                                                  right: Dimensions.width20,
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: Dimensions.height15),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: Dimensions
                                                              .height15),
                                                      child: CircleAvatar(
                                                        maxRadius:
                                                            Dimensions.radius30,
                                                        backgroundImage:
                                                            NetworkImage(AppConstants
                                                                    .BASE_URL +
                                                                AppConstants
                                                                    .UPLOAD_URL +
                                                                reviewList
                                                                    .reviewList[
                                                                        index]
                                                                    .user
                                                                    .profilePicture),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Wrap(
                                                        children: [
                                                          Container(
                                                            color: Colors.white,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: Dimensions
                                                                    .height10,
                                                              ),
                                                              child: Wrap(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      BigText(
                                                                        text: reviewList
                                                                            .reviewList[index]
                                                                            .user
                                                                            .name
                                                                            .toString(),
                                                                      ),
                                                                      SizedBox(
                                                                        width: Dimensions
                                                                            .width30,
                                                                      ),
                                                                      RatingBar
                                                                          .builder(
                                                                        ignoreGestures:
                                                                            true,
                                                                        itemSize:
                                                                            Dimensions.font26,
                                                                        initialRating:
                                                                            double.tryParse(reviewList.reviewList[index].rate)!.toDouble(),
                                                                        minRating:
                                                                            1,
                                                                        direction:
                                                                            Axis.horizontal,
                                                                        allowHalfRating:
                                                                            true,
                                                                        itemCount:
                                                                            5,
                                                                        itemPadding:
                                                                            EdgeInsets.symmetric(horizontal: 0.0),
                                                                        itemBuilder:
                                                                            (context, _) =>
                                                                                Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.amber,
                                                                        ),
                                                                        onRatingUpdate:
                                                                            (rating) {},
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: Dimensions
                                                                        .width30,
                                                                  ),
                                                                  Text(
                                                                    f
                                                                        .format(reviewList
                                                                            .reviewList[index]
                                                                            .createdAt)
                                                                        .toString(),
                                                                  ),
                                                                  SizedBox(
                                                                    height: Dimensions
                                                                        .width30,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          reviewList
                                                                              .reviewList[index]
                                                                              .review,
                                                                          style:
                                                                              TextStyle(overflow: TextOverflow.fade),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })
                                        : CustomLoader(
                                            key: Key("Loading..."),
                                          );
                                  }),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.align_horizontal_left,
                                  size: Dimensions.height30,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: Dimensions.width20,
                                ),
                                Text(
                                  "See All Reviews",
                                  style: TextStyle(
                                      fontFamily: 'TiroKannada',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber[800],
                                      fontSize: Dimensions.font16 + 2),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height50 * 2,
                          ),
                          Text("Popular Comments Here"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              paymetMethod(),
              Center(
                child: Text('Calls Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

paymetMethod() {
  final f = new DateFormat.yMd();
  return DefaultTabController(
    length: 2,
    child: Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: new Size.fromHeight(20),
            child: Container(
              child: TabBar(
                isScrollable: false,
                indicatorWeight: 3.0,
                indicatorColor: Colors.blue[200],
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: <Widget>[
                  Tab(
                    // icon: Icon(
                    //   Icons.today,
                    //   color: Colors.green,
                    // ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 7,
                                offset: Offset(1, 10),
                                color: Colors.white.withOpacity(0.2))
                          ]),
                      child: Text(
                        'Add Payment',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.font16,
                            fontFamily: 'TiroKannada',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                  Tab(
                    // icon: Icon(
                    //   Icons.assessment,
                    //   color: Colors.green,
                    // ),
                    child: Text(
                      'Edit Payment',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.font16,
                          fontFamily: 'TiroKannada',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius30),
                  topRight: Radius.circular(Dimensions.radius30),
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(bottom: 30),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width50,
                            top: Dimensions.height50),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 23,
                                  spreadRadius: 0.1,
                                  offset: Offset(1, 2),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: SingleChildScrollView(
                          child: Column(
                            // mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(
                                      right: Dimensions.width20),
                                  padding: EdgeInsets.only(
                                    top: Dimensions.height20,
                                  ),
                                  child: Text("Add Payment Method",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'TiroKannada',
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1))),
                              _textInput(
                                  hint: "Account Holder", icon: Icons.person),
                              _textInput(
                                  hint: "Account Number", icon: Icons.email),
                              _textInput(
                                  hint: "Payment Method",
                                  icon: Icons.food_bank),
                              SizedBox(
                                height: Dimensions.height50,
                              ),
                              Container(
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [Colors.blue, Colors.blue],
                                        end: Alignment.centerLeft,
                                        begin: Alignment.centerRight),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    )),
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: "Add",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Dimensions.font20)),
                                    ]),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius30),
                  topRight: Radius.circular(Dimensions.radius30),
                ),
              ),
              child: GetBuilder<BookingController>(builder: (todayToBeDone) {
                return todayToBeDone.isLoad
                    ? ListView.builder(
                        physics:
                            AlwaysScrollableScrollPhysics(), //the whole page is scrollable but using alwaysscrolla
                        shrinkWrap: true,
                        itemCount:
                            todayToBeDone.todayToBeDoneBookingList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Get.toNamed(RouteHelper.getRecomendedFood(index));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.height50,
                                  left: Dimensions.width20,
                                  right: Dimensions.width20,
                                  bottom: Dimensions.height10),
                              child: Row(
                                children: [
                                  //image section
                                  GestureDetector(
                                    onTap: () {
                                      // Get.toNamed(
                                      //     RouteHelper.getPopularService(
                                      //         index));
                                    },
                                    child: CircleAvatar(
                                      radius: Dimensions.radius30 * 2,
                                      backgroundImage: NetworkImage(
                                          todayToBeDone
                                              .todayToBeDoneBookingList[index]
                                              .user
                                              .profilePicture),
                                    ),
                                  ),
                                  //TExT container

                                  Expanded(
                                    // to ToBeDoneow the width to take ToBeDone the available width

                                    child: Container(
                                      height: Dimensions.ListViewTextSize,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: Dimensions.width10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            BigText(
                                              text: todayToBeDone
                                                  .todayToBeDoneBookingList[
                                                      index]
                                                  .user
                                                  .name,
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10,
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Service Type : ",
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Dimensions.width20,
                                                  ),
                                                  Text(
                                                    todayToBeDone
                                                        .todayToBeDoneBookingList[
                                                            index]
                                                        .service
                                                        .name,
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.calendar_today_rounded,
                                                  color: Colors.blue,
                                                  size: Dimensions.font16,
                                                ),
                                                SizedBox(
                                                    width: Dimensions.width10),
                                                Text(f.format(todayToBeDone
                                                    .todayToBeDoneBookingList[
                                                        index]
                                                    .user
                                                    .createdAt))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                    : CustomLoader();
              }),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _textInput({controller, hint, icon}) {
  return Container(
    margin: EdgeInsets.only(
        top: Dimensions.height20,
        left: Dimensions.width20,
        right: Dimensions.width20),
    width: double.infinity,
    height: 40,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius30),
        boxShadow: [
          BoxShadow(
              blurRadius: 12,
              spreadRadius: 5,
              offset: Offset(1, 10),
              color: Colors.grey.withOpacity(0.2))
        ]),
    padding: EdgeInsets.only(left: 10),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        prefixIcon: Icon(icon),
      ),
    ),
  );
}
