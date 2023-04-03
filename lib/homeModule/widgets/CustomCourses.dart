import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mmt_courses/homeModule/providers/courses.dart';
import 'package:mmt_courses/homeModule/screens/detail_page_screen.dart';
import 'package:provider/provider.dart';

import '../../authModule/models/user.dart';
import '../../authModule/providers/users.dart';
import '../models/course.dart';

class CustomCourses extends StatefulWidget {
  final bool isFree;

  const CustomCourses({
    super.key,
    required this.isFree,
  });

  @override
  State<CustomCourses> createState() => _CustomCoursesState();
}

class _CustomCoursesState extends State<CustomCourses> {
  List<Course> course = [];
  User user = User(
      name: "",
      imagePath: "",
      birthDate: DateTime.now(),
      gender: "",
      email: "",
      mobileNumber: "",
      wishlistCourseIds: [],
      enrolledCourseIds: []);

  @override
  void initState() {
    super.initState();
    user = Provider.of<Users>(context, listen: false).fetchUser();
    if (widget.isFree) {
      course =
          Provider.of<Courses>(context, listen: false).fetchAllFreeCourses();
    } else {
      course =
          Provider.of<Courses>(context, listen: false).fecthAllPaidCourses();
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<Users>(context).fetchUser();
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.isFree ? "Free Courses" : "Paid Courses",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                "see all",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              )
            ],
          ),
        ),
        SizedBox(
          height: 14,
        ),
        Container(
          height: 208,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (ctx, i) => GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(DetailPageScreen.routeName,
                    arguments: course[i].id);
              },
              child: Container(
                width: 272,
                margin: EdgeInsets.only(
                  left: 24,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 128,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: course[i].imageBgColor),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 16, top: 13),
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 11,
                                  margin: EdgeInsets.only(right: 2),
                                  child: SvgPicture.asset(
                                      "assets/images/star.svg"),
                                ),
                                Text(
                                  "4.8",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "(1200+)",
                                  style: TextStyle(
                                      color: Color.fromRGBO(115, 115, 115, 1),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 24, bottom: 8, top: 8),
                            child: Stack(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: double.infinity,
                                  height: 84,
                                  child: Image.asset(course[i].image),
                                ),
                                /*Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(right: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        course[i].imageText![0],
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: course[i].imgTextColor),
                                      ),
                                      Text(
                                        course[i].imageText![1],
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: course[i].imgTextColor),
                                      ),
                                      Text(
                                        course[i].imageText![2],
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: course[i].imgTextColor),
                                      )
                                    ],
                                  ),
                                )*/
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 16, bottom: 8, right: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course[i].title,
                              style: TextStyle(
                                  color: Color.fromRGBO(36, 36, 36, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              course[i].subtitle,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromRGBO(115, 115, 115, 1),
                                  fontWeight: FontWeight.w400),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "By Tushar R. Gone",
                                  style: TextStyle(
                                      color: Color.fromRGBO(115, 115, 115, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10),
                                ),
                                user.enrolledCourseIds.contains(course[i].id)
                                    ? Text(
                                        "ENROLLED",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(67, 67, 67, 1),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14),
                                      )
                                    : (widget.isFree
                                        ? Text(
                                            "FREE",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    67, 67, 67, 1),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14),
                                          )
                                        : Row(
                                            children: [
                                              Text(
                                                "₹" +
                                                    course[i]
                                                        .discountedPrice
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        67, 67, 67, 1),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                "₹" +
                                                    course[i]
                                                        .originalPrice
                                                        .toStringAsFixed(2),
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(
                                                        115, 115, 115, 1)),
                                              )
                                            ],
                                          ))
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            itemCount: course.length,
          ),
        )
      ],
    );
  }
}
