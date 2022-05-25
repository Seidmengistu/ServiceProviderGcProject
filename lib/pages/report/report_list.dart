import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider/base/custom_loader.dart';
import 'package:service_provider/controllers/review/review_controller.dart';
import 'package:service_provider/controllers/service/popular_service_controller.dart';
import 'package:service_provider/routes/route_helper.dart';
import 'package:service_provider/utils/app_constants.dart';
import 'package:service_provider/utils/dimensions.dart';
import 'package:service_provider/widgets/big_text.dart';
import 'package:service_provider/widgets/icon_and_text_widget.dart';
import 'package:service_provider/widgets/small_text.dart';

class ReportList extends StatefulWidget {
  const ReportList({Key? key}) : super(key: key);
  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  Widget build(BuildContext context) {
    Get.find<ReviewController>().getReviewList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.blue[300],
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
                  tabs: [
                    Tab(
                      text: 'Review',
                    ),
                    Tab(
                      text: 'Payment',
                    ),
                    Tab(
                      text: 'Withdraw Reqest',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Container(
          child: TabBarView(
            children: [
              Center(
                  child: Container(
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            width: Dimensions.width50,
                          ),
                          // AppTextField(
                          //   hintText: "Search Booking",
                          //   icon: Icons.add,
                          //   textController: searchController,
                          // ),
                          // TextField(),
                          SizedBox(
                            width: Dimensions.width50 + 55,
                          ),
                          IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.height10 / 2),
                    Container(
                      height: MediaQuery.of(context).size.height - 185.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius30),
                          topRight: Radius.circular(Dimensions.radius30),
                        ),
                      ),
                      child:
                          GetBuilder<ReviewController>(builder: (reviewList) {
                        return !reviewList.isLoad
                            ? ListView.builder(
                                physics:
                                    AlwaysScrollableScrollPhysics(), //the whole page is scrollable but using alwaysscrolla
                                shrinkWrap: true,
                                itemCount: reviewList.reviewList.length,
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
                                              height:
                                                  Dimensions.ListViewImgSize,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius20),
                                                color: Colors.grey,
                                                // image: DecorationImage(
                                                //   fit: BoxFit.cover,
                                                //   // image: NetworkImage(AppConstants
                                                //   //         .BASE_URL +
                                                //   //     AppConstants.UPLOAD_URL +
                                                //   //     popularServices
                                                //   //         .popularServiceList[
                                                //   //             index]
                                                //   //         .image),
                                                // ),
                                              ),
                                            ),
                                          ),
                                          //TExT container

                                          Expanded(
                                            // to allow the width to take all the available width

                                            child: Container(
                                              height:
                                                  Dimensions.ListViewTextSize,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
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
                                                      text: reviewList
                                                          .reviewList[index]
                                                          .review,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Dimensions.height10,
                                                    ),
                                                    SmallText(text: ""),
                                                    SizedBox(
                                                      height:
                                                          Dimensions.height10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        IconAndTextWidget(
                                                          icon: Icons
                                                              .calendar_today_rounded,
                                                          text: reviewList
                                                              .reviewList[index]
                                                              .rate,
                                                          iconColor:
                                                              Colors.blue,
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
                            : CustomLoader(
                                key: Key("Loading..."),
                              );
                      }),
                    )
                  ],
                ),
              )),
              Center(
                child: Text('Status Page'),
              ),
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
