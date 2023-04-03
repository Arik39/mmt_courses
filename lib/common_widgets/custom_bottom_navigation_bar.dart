import 'package:flutter/material.dart';
import 'package:mmt_courses/homeModule/providers/navigatioBarHandler.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 5,
      onTap: (index) =>
          Provider.of<NavigationBarHandler>(context, listen: false)
              .selectPage(index),
      backgroundColor: Colors.white,
      showUnselectedLabels: true,
      unselectedItemColor: Color.fromRGBO(115, 115, 115, 1),
      selectedItemColor: Theme.of(context).primaryColor,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.play_circle_outline_rounded),
          label: "My Courses",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_outlined),
          label: "Community",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border_rounded),
          label: "WishList",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: "More",
        ),
      ],
      currentIndex: Provider.of<NavigationBarHandler>(context, listen: false)
          .selectedPageIndexGetter(),
    );
  }
}
