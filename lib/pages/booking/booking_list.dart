import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:service_provider/base/custom_loader.dart';
import 'package:service_provider/base/show_custom_snackbar.dart';
import 'package:service_provider/controllers/booking/booking_controller.dart';
import 'package:service_provider/utils/app_constants.dart';

import 'package:service_provider/utils/dimensions.dart';
import 'package:service_provider/widgets/big_text.dart';
import 'package:service_provider/widgets/icon_and_text_widget.dart';
import 'package:service_provider/widgets/small_text.dart';

class BookingList extends StatefulWidget {
  @override
  _BookingList createState() => _BookingList();
}

class _BookingList extends State<BookingList> {
  @override
  Widget build(BuildContext context) {
    Get.find<BookingController>().gettodayToBeDoneBookingList();
    Get.find<BookingController>().gettodayAllBookingList();
    Get.find<BookingController>().gettodayCompletedBookingList();
    Get.find<BookingController>().getgeneralAllBookingList();
    Get.find<BookingController>().getGeneralToBeDoneBooking();
    Get.find<BookingController>().getGeneralCompletedBooking();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          bottom: TabBar(
            labelColor: Colors.red,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.amberAccent,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              Tab(
                child: Container(
                  child: Text(
                    'Today Booking',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.font16,
                        fontFamily: 'TiroKannada',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    'General Booking',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.font16,
                        fontFamily: 'TiroKannada',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            TodayTabs(),
            GeneralTabs(),
          ],
        ),
      ),
    );
  }

  TodayTabs() {
    final f = new DateFormat.yMd();
    return DefaultTabController(
      length: 3,
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
                      child: Text('Today All',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'TiroKannada',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1)),
                    ),
                    Tab(
                      // icon: Icon(
                      //   Icons.assessment,
                      //   color: Colors.green,
                      // ),
                      child: Text('To be done',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'TiroKannada',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1)),
                    ),
                    Tab(
                      // icon: Icon(
                      //   Icons.add_circle_outline,
                      //   color: Colors.green,
                      // ),
                      child: Text('Completed ',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'TiroKannada',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 185.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius30),
                    topRight: Radius.circular(Dimensions.radius30),
                  ),
                ),
                child: GetBuilder<BookingController>(builder: (todayAll) {
                  return todayAll.isLoad
                      ? ListView.builder(
                          physics:
                              AlwaysScrollableScrollPhysics(), //the whole page is scrollable but using alwaysscrolla
                          shrinkWrap: true,
                          itemCount: todayAll.todayAllBookingList.length,
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
                                    CircleAvatar(
                                      radius: Dimensions.radius30 * 2,
                                      backgroundImage: NetworkImage(todayAll
                                          .todayAllBookingList[index]
                                          .user
                                          .profilePicture),
                                    ),
                                    Expanded(
                                      // to allow the width to take all the available width

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
                                                text: todayAll
                                                    .todayAllBookingList[index]
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
                                                      todayAll
                                                          .todayAllBookingList[
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
                                                    Icons
                                                        .calendar_today_rounded,
                                                    color: Colors.blue,
                                                    size: Dimensions.font16,
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          Dimensions.width10),
                                                  Text(f.format(todayAll
                                                      .todayAllBookingList[
                                                          index]
                                                      .user
                                                      .createdAt))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                      : CustomLoader();
                }),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 185.0,
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                    Icons
                                                        .calendar_today_rounded,
                                                    color: Colors.blue,
                                                    size: Dimensions.font16,
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          Dimensions.width10),
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
              Container(
                height: MediaQuery.of(context).size.height - 185.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius30),
                    topRight: Radius.circular(Dimensions.radius30),
                  ),
                ),
                child: GetBuilder<BookingController>(builder: (todayCompleted) {
                  // if (todayCompleted.todayCompletedBookingList.length == 0) {
                  //   showCustomSnackBar("No Data");
                  // }
                  return todayCompleted.isLoad
                      ? ListView.builder(
                          physics:
                              AlwaysScrollableScrollPhysics(), //the whole page is scrollable but using alwaysscrolla
                          shrinkWrap: true,
                          itemCount:
                              todayCompleted.todayCompletedBookingList.length,
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
                                              todayCompleted
                                                  .todayCompletedBookingList[
                                                      index]
                                                  .user
                                                  .profilePicture),
                                        )),
                                    //TExT container

                                    Expanded(
                                      // to Completedow the width to take Completed the available width

                                      child: Container(
                                        height: Dimensions.ListViewTextSize,
                                        // decoration: BoxDecoration(
                                        //     color: Colors.white,
                                        //     borderRadius: BorderRadius.circular(
                                        //         Dimensions.radius20),
                                        //     boxShadow: [
                                        //       BoxShadow(
                                        //           blurRadius: 10,
                                        //           spreadRadius: 7,
                                        //           offset: Offset(1, 5),
                                        //           color: Colors.blue
                                        //               .withOpacity(0.2))
                                        //     ]),
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
                                                text: todayCompleted
                                                    .todayCompletedBookingList[
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
                                                      todayCompleted
                                                          .todayCompletedBookingList[
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
                                                    Icons
                                                        .calendar_today_rounded,
                                                    color: Colors.blue,
                                                    size: Dimensions.font16,
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          Dimensions.width10),
                                                  Text(f.format(todayCompleted
                                                      .todayCompletedBookingList[
                                                          index]
                                                      .user
                                                      .createdAt))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
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

  GeneralTabs() {
    final f = new DateFormat.yMd();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: new Size.fromHeight(15),
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
                    //   Icons.data_saver_on,
                    //   color: Colors.green,
                    // ),
                    child: Text(
                      'General All',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'TiroKannada',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ),
                  Tab(
                    // icon: Icon(
                    //   Icons.assessment,
                    //   color: Colors.green,
                    // ),
                    child: Text(
                      'To be done',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'TiroKannada',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ),
                  Tab(
                    // icon: Icon(
                    //   Icons.add_circle_outline,
                    //   color: Colors.green,
                    // ),
                    child: Text(
                      'Completed ',
                      style: TextStyle(
                          color: Colors.black,
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
              height: MediaQuery.of(context).size.height - 185.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius30),
                  topRight: Radius.circular(Dimensions.radius30),
                ),
              ),
              child: GetBuilder<BookingController>(builder: (generalAll) {
                return generalAll.isLoad
                    ? ListView.builder(
                        physics:
                            AlwaysScrollableScrollPhysics(), //the whole page is scrollable but using alwaysscrolla
                        shrinkWrap: true,
                        itemCount: generalAll.generalAllBookingList.length,
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
                                        backgroundImage: NetworkImage(generalAll
                                            .generalAllBookingList[index]
                                            .user
                                            .profilePicture),
                                      )),
                                  //TExT container

                                  Expanded(
                                    // to allow the width to take all the available width

                                    child: Container(
                                      height: Dimensions.ListViewTextSize,
                                      // decoration: BoxDecoration(
                                      //     color: Colors.white,
                                      //     borderRadius: BorderRadius.circular(
                                      //         Dimensions.radius20),
                                      //     boxShadow: [
                                      //       BoxShadow(
                                      //           blurRadius: 10,
                                      //           spreadRadius: 7,
                                      //           offset: Offset(1, 5),
                                      //           color: Colors.blue
                                      //               .withOpacity(0.2))
                                      //     ]),
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
                                              text: generalAll
                                                  .generalAllBookingList[index]
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
                                                    generalAll
                                                        .generalAllBookingList[
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
                                                Text(f.format(generalAll
                                                    .generalAllBookingList[
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
            Container(
              height: MediaQuery.of(context).size.height - 185.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius30),
                  topRight: Radius.circular(Dimensions.radius30),
                ),
              ),
              child: GetBuilder<BookingController>(builder: (generalToBeDone) {
                return generalToBeDone.isLoad
                    ? ListView.builder(
                        physics:
                            AlwaysScrollableScrollPhysics(), //the whole page is scrollable but using alwaysscrolla
                        shrinkWrap: true,
                        itemCount: generalToBeDone.gToBeDoneBooking.length,
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
                                            generalToBeDone
                                                .gToBeDoneBooking[index]
                                                .user
                                                .profilePicture),
                                      )),
                                  //TExT container

                                  Expanded(
                                    // to allow the width to take all the available width

                                    child: Container(
                                      height: Dimensions.ListViewTextSize,
                                      // decoration: BoxDecoration(
                                      //     color: Colors.white,
                                      //     borderRadius: BorderRadius.circular(
                                      //         Dimensions.radius20),
                                      //     boxShadow: [
                                      //       BoxShadow(
                                      //           blurRadius: 10,
                                      //           spreadRadius: 7,
                                      //           offset: Offset(1, 5),
                                      //           color: Colors.blue
                                      //               .withOpacity(0.2))
                                      //     ]),
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
                                              text: generalToBeDone
                                                  .gToBeDoneBooking[index]
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
                                                    generalToBeDone
                                                        .gToBeDoneBooking[index]
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
                                                Text(f.format(generalToBeDone
                                                    .gToBeDoneBooking[index]
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
            Container(
              height: MediaQuery.of(context).size.height - 185.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius30),
                  topRight: Radius.circular(Dimensions.radius30),
                ),
              ),
              child: GetBuilder<BookingController>(builder: (generalCompleted) {
                return generalCompleted.isLoad
                    ? ListView.builder(
                        physics:
                            AlwaysScrollableScrollPhysics(), //the whole page is scrollable but using alwaysscrolla
                        shrinkWrap: true,
                        itemCount: generalCompleted.gCompletedBooking.length,
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
                                            generalCompleted
                                                .gCompletedBooking[index]
                                                .user
                                                .profilePicture),
                                      )),
                                  //TExT container

                                  Expanded(
                                    // to allow the width to take all the available width

                                    child: Container(
                                      height: Dimensions.ListViewTextSize,
                                      // decoration: BoxDecoration(
                                      //     color: Colors.white,
                                      //     borderRadius: BorderRadius.circular(
                                      //         Dimensions.radius20),
                                      //     boxShadow: [
                                      //       BoxShadow(
                                      //           blurRadius: 10,
                                      //           spreadRadius: 7,
                                      //           offset: Offset(1, 5),
                                      //           color: Colors.blue
                                      //               .withOpacity(0.2))
                                      //     ]),
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
                                              text: generalCompleted
                                                  .gCompletedBooking[index]
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
                                                    generalCompleted
                                                        .gCompletedBooking[
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
                                                Text(f.format(generalCompleted
                                                    .gCompletedBooking[index]
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
    );
  }
}
