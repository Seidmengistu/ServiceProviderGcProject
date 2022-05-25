import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:service_provider/controllers/service/popular_service_controller.dart';
import 'package:service_provider/main.dart';
import 'package:service_provider/models/service/service_model.dart';
import 'package:service_provider/pages/services/home_page.dart';
import 'package:service_provider/pages/services/main_service_page.dart';
import 'package:service_provider/pages/services/popular_service_detail.dart';
import 'package:service_provider/routes/route_helper.dart';

import 'package:service_provider/utils/app_constants.dart';
import 'package:service_provider/utils/dimensions.dart';
import 'package:service_provider/widgets/app_column.dart';
import 'package:service_provider/widgets/big_text.dart';
import 'package:service_provider/widgets/icon_and_text_widget.dart';
import 'package:service_provider/widgets/small_text.dart';

import 'package:get/get.dart';

class ServiceList extends StatefulWidget {
  const ServiceList({Key? key}) : super(key: key);

  @override
  State<ServiceList> createState() => _ServiceListBodyState();
}

class _ServiceListBodyState extends State<ServiceList> {
  var service = Get.find<PopularServiceController>().popularServiceList;

  PageController pageController = PageController(
      viewportFraction:
          0.85); // during iamge move to show some part of next image

  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 220;
  double height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!; //not going to be null !shows
        // print("current page value is" + _currPageValue.toString());
      });
    });
  }

  @override //to avoid memory linkage after we leave the page no need to run
  void dispose() {
    pageController.dispose(); // to use small memory
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PopularServiceController>();
    controller.getPopularServiceList();
    return Column(
      children: [
        //Slider Section
        //Get Builder connect PopularServiceController with the UI
        GetBuilder<PopularServiceController>(builder: (popularServices) {
          return popularServices.isLoad
              ? Container(
                  // color: Colors.redAccent,
                  height: Dimensions.pageView,

                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularServices.popularServiceList
                          .length, //USING Public get length of product list
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularServices.popularServiceList[position]);
                      }),
                )
              : CircularProgressIndicator(
                  color: Colors.blue,
                  backgroundColor: Colors.green,
                );
        }),

        //dots
        GetBuilder<PopularServiceController>(builder: (popularServices) {
          return DotsIndicator(
            dotsCount: popularServices.popularServiceList.isEmpty
                ? 1
                : popularServices.popularServiceList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: Colors.greenAccent,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        //popular text
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Popular Services"),
              SizedBox(
                width: Dimensions.width10,
              ), //space before the dot

              SizedBox(
                width: Dimensions.width10,
              ), //space after the dot
            ],
          ),
        ),
        // recomended food
        //list of food and images
        // GetBuilder<RecomendedProductController>(builder: (recomendedProducts) {
        //   return recomendedProducts.isLoaded
        //       ?
        ListView.builder(
            physics:
                NeverScrollableScrollPhysics(), //the whole page is scrollable but using alwaysscrolla
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Get.toNamed(RouteHelper.getRecomendedFood(index));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.height10),
                  child: Row(
                    children: [
                      //image section
                      GestureDetector(
                        onTap: () {
                          // RouteHelper.recomendedFood;
                        },
                        child: Container(
                          width: Dimensions.ListViewImgSize,
                          height: Dimensions.ListViewImgSize,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white38,
                            // image: DecorationImage(
                            //   fit: BoxFit.cover,
                            //   // image: AssetImage(

                            //   //   // AppConstants.BASE_URL +
                            //   //   //   AppConstants.UPLOAD_URL +
                            //   //   //    recomendedProducts
                            //   //   //        .recomendedProductList[index].img

                            //   //         ),
                            // ),
                          ),
                        ),
                      ),
                      //TExT container

                      Expanded(
                        // to allow the width to take all the available width

                        child: Container(
                          height: Dimensions.ListViewTextSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius20),
                              bottomRight: Radius.circular(Dimensions.radius20),
                            ),
                            color: Colors.white,

                            // boxShadow: BoxShadow()
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimensions.width10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(text: "service Name"
                                    // recomendedProducts
                                    //     .recomendedProductList[index]
                                    //     .name!
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
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndTextWidget(
                                      icon: Icons.rate_review_rounded,
                                      text: "Rating",
                                      iconColor: Colors.orangeAccent,
                                    ),
                                    SizedBox(
                                      width: Dimensions.width20,
                                    ),
                                    IconAndTextWidget(
                                      icon: Icons.location_on,
                                      text: "1.7 km",
                                      iconColor: Colors.lightBlue,
                                    ),
                                    SizedBox(
                                      width: Dimensions.width20,
                                    ),
                                    IconAndTextWidget(
                                      icon: Icons.access_time_rounded,
                                      text: "32 smin",
                                      iconColor: Colors.red,
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
      ],
    );
  }

  Widget _buildPageItem(int index, ServiceModel popularService) {
//for scale up and down

    Matrix4 matrix = new Matrix4.identity();

    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor); //
      var currTrans = _height * (1 - currScale) / 2; //1/10*220=22
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) // for the next page
    {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans =
          _height * (1 - currScale) / 2; //to reduce the height during transform
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) // for the back page
    {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor); //
      var currTrans =
          _height * (1 - currScale) / 2; //to reduce the height during transform
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        //wrap it with transform widget to see the change of the matrix
        //used to put 2 container over each other
        children: [
          GestureDetector(
            onTap: () {
              // send parameter
              Get.toNamed(RouteHelper.getPopularService(index),
                  arguments: index);
              // pushNewScreenWithRouteSettings(
              //   context,
              //   settings:
              //       RouteSettings(name: RouteHelper.getPopularService(index)),
              //   screen: PopularServiceDetail(
              //     pageId: index,
              //   ),
              //   withNavBar: true,
              //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
              // );
            },
            child: Container(
              height: Dimensions
                  .pageViewContainer, //it use this height instead of the parent 320
              margin: EdgeInsets.only(
                  left: Dimensions.width10,
                  right: Dimensions.width10), //space between images
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      popularService.image!),
                ),
              ),
            ),
          ),
          Align(
            // to make the second container at the bootom instead of using marigin top
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions
                  .pageViewTextContainer, //it use this height instead of the parent 320c
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30), //space between images

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),

              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    left: Dimensions.width15,
                    right: Dimensions.width15),
                child: AppColumn(
                  text: popularService.name!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
