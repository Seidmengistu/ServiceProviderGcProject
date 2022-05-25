import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider/controllers/service/popular_service_controller.dart';
import 'package:service_provider/routes/route_helper.dart';
import 'package:service_provider/utils/dimensions.dart';
import 'package:service_provider/widgets/app_icon.dart';
import 'package:service_provider/widgets/big_text.dart';
import 'package:service_provider/widgets/expandable_text_widget.dart';

class BookingDetail extends StatelessWidget {
  final int pageId;
  BookingDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularServiceController>().popularServiceList[pageId];

    return Scaffold(
      backgroundColor: Colors.white,
      //food description
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimensions.AppToolbarSize,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () => RouteHelper.getIntial(),
                    child: AppIcon(icon: Icons.clear)),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(
                    child: BigText(
                        size: Dimensions.font26,
                        text: "Ethiopian Food Description")),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: const Color(0xFFFFCA28),
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
                // background: Image.network(
                //   AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                //   width: double.maxFinite,
                //   fit: BoxFit.cover,
                // ),
                ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableTextWidget(text: "desc"
                      // product.description!
                      ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20 * 2.5,
                right: Dimensions.width20 * 2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                    iconSize: Dimensions.iconSize24,
                    IconColor: Colors.white,
                    backgroundColor: const Color(0xFF4DB6AC),
                    icon: Icons.remove),
                BigText(
                  // text: "\$ ${product.price}  X  0",
                  text: "price",
                  color: Colors.black,
                  size: Dimensions.font26,
                ),
                AppIcon(
                    iconSize: Dimensions.iconSize24,
                    IconColor: Colors.white,
                    backgroundColor: const Color(0xFF4DB6AC),
                    icon: Icons.add),
              ],
            ),
          ),
          Container(
            height: Dimensions.BottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20 * 2),
                topLeft: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.favorite,
                    size: Dimensions.iconSize24,
                    color: const Color(0xFF4DB6AC),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width50,
                      right: Dimensions.width50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: const Color(0xFF4DB6AC),
                  ),
                  child: BigText(
                    text: ("\$10 | Add to cart"),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
