import 'package:flutter/material.dart';
import 'package:mmt_courses/authModule/providers/users.dart';
import 'package:mmt_courses/authModule/widgets/custom_button.dart';
import 'package:mmt_courses/homeModule/widgets/wishlist_tile.dart';
import 'package:provider/provider.dart';

import '../../authModule/models/user.dart';
import '../models/course.dart';
import '../providers/courses.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late List<Course> course;
  bool isSelect = false;
  User user = User(
      name: "",
      imagePath: "",
      birthDate: DateTime.now(),
      gender: "",
      email: "",
      mobileNumber: "",
      wishlistCourseIds: [],
      enrolledCourseIds: []);

  List<String> selectedCourseId = [];

  void addOrRemoveItem(String id) {
    if (selectedCourseId.contains(id)) {
      selectedCourseId.remove(id);
    } else {
      selectedCourseId.add(id);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = Provider.of<Users>(context, listen: false).fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<Users>(context).fetchUser();
    course = Provider.of<Courses>(context)
        .fetchWishlistItems(user.wishlistCourseIds);
    final deviceW = MediaQuery.of(context).size.width;
    final deviceH = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isSelect = !isSelect;
                });
              },
              child: Text(isSelect ? "CANCEL" : "SELECT"),
            ),
          ),
          Container(
            height: isSelect ? deviceH * .5 : deviceH * .6,
            width: deviceW,
            child: ListView.builder(
                itemCount: course.length,
                itemBuilder: (ctx, i) {
                  return Container(
                    padding: EdgeInsets.only(top: 10),
                    child: WishlistTile(
                      course: course[i],
                      isSelectedMenuEnable: isSelect,
                      addOrRemoveItem: addOrRemoveItem,
                      selectedCourseId: selectedCourseId,
                    ),
                  );
                }),
          ),
          Visibility(
            visible: isSelect && course.length > 0,
            child: Container(
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {
                        Provider.of<Users>(context, listen: false)
                            .toggleAllSelectedWishItems(selectedCourseId);
                      },
                      child: Text(
                        "Remove from list",
                        style: TextStyle(
                            color: Color.fromRGBO(67, 67, 67, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )),
                  CustomButton(
                      buttonText: "BUY NOW", onTap: () {}, isEnable: true)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
