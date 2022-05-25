import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider/controllers/service/popular_service_controller.dart';
import 'package:service_provider/routes/route_helper.dart';
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
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[300],
            title: Padding(
              padding: EdgeInsets.only(top: 1.0),
            ),
            bottom: TabBar(
              indicatorColor: Colors.pink,
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.black54,
              tabs: <Widget>[
                Tab(
                  child: Container(
                    child: Text(
                      'Today',
                      style: TextStyle(
                          color: Colors.white, fontSize: Dimensions.font20),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'General',
                      style: TextStyle(
                          color: Colors.white, fontSize: Dimensions.font20),
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
        ));
  }

  TodayTabs() {
    return DefaultTabController(
      length: 3,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: TabBar(
              isScrollable: true,
              indicatorWeight: 3.0,
              indicatorColor: Colors.red,
              unselectedLabelColor: Colors.black,
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.today,
                    color: Colors.green,
                  ),
                  child: Text(
                    'Today All',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.assessment,
                    color: Colors.green,
                  ),
                  child: Text(
                    'To be done',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.green,
                  ),
                  child: Text(
                    'Completed Booking',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
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
                child: GetBuilder<PopularServiceController>(
                    builder: (popularServices) {
                  return popularServices.isLoad
                      ? ListView.builder(
                          physics:
                              AlwaysScrollableScrollPhysics(), //the whole page is scrollable but using alwaysscrolla
                          shrinkWrap: true,
                          itemCount: popularServices.popularServiceList.length,
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
                                        Get.toNamed(
                                            RouteHelper.getPopularService(
                                                index));
                                      },
                                      child: Container(
                                        width: Dimensions.ListViewImgSize,
                                        height: Dimensions.ListViewImgSize,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                          color: Colors.grey,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(AppConstants
                                                    .BASE_URL +
                                                AppConstants.UPLOAD_URL +
                                                popularServices
                                                    .popularServiceList[index]
                                                    .image),
                                          ),
                                        ),
                                      ),
                                    ),
                                    //TExT container

                                    Expanded(
                                      // to allow the width to take all the available width

                                      child: Container(
                                        height: Dimensions.ListViewTextSize,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 10,
                                                  spreadRadius: 7,
                                                  offset: Offset(1, 5),
                                                  color: Colors.blue
                                                      .withOpacity(0.2))
                                            ]),
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
                                                text: popularServices
                                                    .popularServiceList[index]
                                                    .name,
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10,
                                              ),
                                              SmallText(text: ""),
                                              SizedBox(
                                                height: Dimensions.height10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconAndTextWidget(
                                                    icon: Icons
                                                        .calendar_today_rounded,
                                                    text: popularServices
                                                        .popularServiceList[
                                                            index]
                                                        .createdAt,
                                                    iconColor: Colors.blue,
                                                  ),
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
                      : CircularProgressIndicator(
                          color: Colors.blue,
                        );
                }),
              ),
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }

  GeneralTabs() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            isScrollable: true,
            indicatorWeight: 6.0,
            indicatorColor: Colors.red,
            unselectedLabelColor: Colors.black,
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.trending_up,
                  color: Colors.green,
                ),
                child: Text(
                  'General All',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.assessment,
                  color: Colors.green,
                ),
                child: Text(
                  'To be done',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.green,
                ),
                child: Text(
                  'Completed Booking',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
