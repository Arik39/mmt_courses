import 'package:flutter/material.dart';

import 'package:mmt_courses/common_widgets/custom_background_container.dart';
import 'package:mmt_courses/common_widgets/custom_bottom_navigation_bar.dart';
import 'package:mmt_courses/homeModule/providers/navigatioBarHandler.dart';
import 'package:mmt_courses/homeModule/screens/home_page_screen.dart';
import 'package:mmt_courses/homeModule/screens/more_menu_screen.dart';
import 'package:mmt_courses/homeModule/screens/wishlist_screen.dart';
import 'package:provider/provider.dart';

import 'my_course_screen.dart';

class Dashboard extends StatefulWidget {
  static const routeName = "/dashboard";

  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    int _selectedPageIndex =
        Provider.of<NavigationBarHandler>(context).selectedPageIndexGetter();

    final List _pages = [
      HomePageScreen(),
      MyCourseScreen(),
      Container(),
      WishlistScreen(),
      MoreMenuScreen(),
    ];
    return CustomBackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: SafeArea(child: _pages[_selectedPageIndex]),
        bottomNavigationBar: Container(
          child: CustomBottomNavigationBar(),
        ),
      ),
    );
  }
}
