import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mmt_courses/authModule/widgets/custom_button.dart';
import 'package:mmt_courses/homeModule/providers/courses.dart';
import 'package:provider/provider.dart';

import '../../authModule/models/user.dart';
import '../../authModule/providers/users.dart';
import '../models/course.dart';
import '../providers/navigatioBarHandler.dart';
import '../widgets/my_course_tile.dart';

class MyCourseScreen extends StatefulWidget {
  static const routeName = "/my-course-screen";

  MyCourseScreen({Key? key}) : super(key: key);

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen>
    with TickerProviderStateMixin {
  late TabController _controller;
  User user = User(
      name: "",
      imagePath: "",
      birthDate: DateTime.now(),
      gender: "",
      email: "",
      mobileNumber: "",
      wishlistCourseIds: [],
      enrolledCourseIds: []);
  List<Course> course = [
    Course(
      noOfModules: 0,
      timeToCompleteCourse: 0,
      courseHighlights: [],
      requirements: [],
      aboutInstructor: {},
      moduleLevel: "",
      categoryType: "",
      title: "",
      image: "",
      subtitle: "",
      isFree: true,
      originalPrice: 0,
      discountedPrice: 0,
      tags: [],
      review: {},
      description: "",
    )
  ];

  @override
  void initState() {
    super.initState();
    _controller = new TabController(vsync: this, length: 2);
    user = Provider.of<Users>(context, listen: false).fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<Users>(context).fetchUser();
    course = Provider.of<Courses>(context)
        .fetchAllEnrolledCourses(user.enrolledCourseIds);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 29),
              child: Text(
                "My Course",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              )),
          Container(
            child: TabBar(
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Color.fromRGBO(115, 115, 115, 1),
              labelColor: Color.fromRGBO(39, 39, 46, 1),
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14, letterSpacing: 1),
              tabs: [
                Tab(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text(
                      "ONGOING",
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text(
                      "COMPLETED",
                    ),
                  ),
                )
              ],
              controller: _controller,
            ),
          ),
          Expanded(
              child: TabBarView(
            controller: _controller,
            children: [
              Container(
                child: course.length == 0
                    ? CustomEmptyDisplay(message: "No Enrolled courses")
                    : ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return MyCourseTile(
                            isStarted: false,
                            title: course[index].title,
                            courseCompletionPctOfTotal: .2,
                            id: course[index].id!,
                            imgPath: course[index].image,
                          );
                        },
                        itemCount: course.length,
                      ),
              ),
              Container(
                child: CustomEmptyDisplay(message: "No Completed courses"),
              )
            ],
          ))
        ],
      ),
    );
  }
}

class CustomEmptyDisplay extends StatelessWidget {
  final String message;

  const CustomEmptyDisplay({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/images/smile.svg"),
        SizedBox(
          height: 12,
        ),
        Text(message),
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
              buttonText: "Explore Courses",
              onTap: () {
                Provider.of<NavigationBarHandler>(context, listen: false)
                    .selectPage(0);
              },
              isEnable: true),
        )
      ],
    );
  }
}
