import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:service_provider/pages/booking/booking_list.dart';

import 'package:service_provider/pages/dashboard.dart';
import 'package:service_provider/pages/report/report_list.dart';
import 'package:service_provider/pages/services/main_service_page.dart';
import 'package:service_provider/utils/dimensions.dart';

class SHomePage extends StatefulWidget {
  final int selectedIndex;

  SHomePage({
    required this.selectedIndex,
  });

  @override
  State<SHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<SHomePage> {
  late PersistentTabController _controller;

  // get selectedIndex => SHomePage(selectedIndex: selectedIndex);

  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      Dashboard(),
      MainServiceList(),
      BookingList(),
      ReportList(),
      Container(
        child: Center(child: Text("Settings")),
      )
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        textStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'TiroKannada',
            fontWeight: FontWeight.bold,
            letterSpacing: 1),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.room_service),
        title: ("Services"),
        textStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'TiroKannada',
            fontWeight: FontWeight.bold,
            letterSpacing: 1),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.book_online),
        title: ("Booking"),
        textStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'TiroKannada',
            fontWeight: FontWeight.bold,
            letterSpacing: 1),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.report),
        title: ("Report"),
        textStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'TiroKannada',
            fontWeight: FontWeight.bold,
            letterSpacing: 1),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Settings"),
        textStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'TiroKannada',
            fontWeight: FontWeight.bold,
            letterSpacing: 1),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.black,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,

      backgroundColor: Colors.white, // Default is Colors. .
      handleAndroidBackButtonPress: false, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style4, // Choose the nav bar style with this property.
    );
  }
}
