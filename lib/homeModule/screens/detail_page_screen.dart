import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mmt_courses/authModule/models/user.dart';
import 'package:mmt_courses/authModule/providers/users.dart';
import 'package:mmt_courses/common_widgets/custom_background_container.dart';
import 'package:mmt_courses/homeModule/providers/courses.dart';
import 'package:mmt_courses/homeModule/screens/checkout_screen.dart';
import 'package:mmt_courses/homeModule/screens/enrollment_success_screen.dart';
import 'package:mmt_courses/homeModule/widgets/custom_curriculum_tile.dart';
import 'package:provider/provider.dart';

import '../../authModule/widgets/custom_button.dart';
import '../providers/navigatioBarHandler.dart';
import '../widgets/heading.dart';
import '../widgets/tag.dart';
import 'dashboard.dart';

class DetailPageScreen extends StatefulWidget {
  static const routeName = "/detail-page";

  const DetailPageScreen({Key? key}) : super(key: key);

  @override
  State<DetailPageScreen> createState() => _DetailPageScreenState();
}

class _DetailPageScreenState extends State<DetailPageScreen> {
  late User user;
  bool isWishlist = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = Provider.of<Users>(context, listen: false).fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final course = Provider.of<Courses>(context).fetchByCourseId(id);
    user = Provider.of<Users>(context).fetchUser();

    return CustomBackgroundContainer(
      child: Stack(
        children: [
          Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              flexibleSpace: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.only(top: 50),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: SvgPicture.asset("assets/images/back.svg")),
                      GestureDetector(
                          onTap: () async {
                            await Provider.of<Users>(context, listen: false)
                                .isWishlist(id);
                          },
                          child:
                              // child: user.wishlistCourseIds.contains(course.id)
                              user.wishlistCourseIds.contains(id)
                                  ? SvgPicture.asset(
                                      "assets/images/bookmark_fill.svg")
                                  : SvgPicture.asset(
                                      "assets/images/bookmark.svg")),
                    ],
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          course.aboutInstructor["name"],
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        CircleAvatar(
                          radius: 14,
                          child: Image.asset("assets/images/profile_image.png"),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      course.title,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "STOCK MARKET",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: 4),
                                height: 16,
                                width: 17.45,
                                child:
                                    SvgPicture.asset("assets/images/star.svg")),
                            Text(
                              "4.8 (1200+ enrolls)",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: course.categoryType == 'paid',
                          child: Column(
                            children: [
                              Text(
                                course.originalPrice.toStringAsFixed(2),
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Color.fromRGBO(115, 115, 115, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 1),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  course.discountedPrice.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/images/level.svg"),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Beginner",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset("assets/images/modules.svg"),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              course.noOfModules.toString() + " Modules",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset("assets/images/clock.svg"),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              course.timeToCompleteCourse.toString() + " Hours",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 49,
                    ),
                    Heading(heading: "Course Highlights"),
                    Container(
                        margin: EdgeInsets.only(top: 15, bottom: 48),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...course.courseHighlights
                                .map((cor) => Text(
                                      cor.toString(),
                                      style: TextStyle(
                                          color: Color.fromRGBO(67, 67, 67, 1),
                                          fontSize: 14,
                                          height: .7,
                                          fontWeight: FontWeight.w600),
                                    ))
                                .toList()
                          ],
                        )

                        /*child: RichText(
                        text: TextSpan(

                            children: [
                              TextSpan(text: ),
                              TextSpan(
                                  text:
                                      "\n\u2022 4 Hours of Interactive Content"),
                              TextSpan(
                                  text: "\n\u2022 Level of Content - Beginner"),
                              TextSpan(
                                  text:
                                      "\n\u2022 Quizzes and Resources Included"),
                              TextSpan(
                                  text: "\n\u2022 Community Support Available"),
                            ]),
                      ),*/
                        ),
                    Heading(heading: "About Course"),
                    Container(
                      height: 150,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 15, bottom: 48),
                      padding: EdgeInsets.only(left: 5),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Color.fromRGBO(67, 67, 67, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                  text:
                                      "This Course is a comprehensive course in  stock market trading that will take you from beginner to advance level.  You will be able to trade like a professional trader and start earning regular income after a few months of practice with our support. More..."),
                            ]),
                      ),
                    ),
                    Heading(
                      heading: 'Curriculum',
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 17),
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        children: [
                          CustomCurriculumTile(title: "01 - Welcome Session"),
                          CustomCurriculumTile(
                              title: "02 - Concepts of Trading"),
                          CustomCurriculumTile(title: "03 - Tools for Trading"),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 49),
                      alignment: Alignment.center,
                      child: Text(
                        "See More",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Heading(heading: "Requirements"),
                    Container(
                        margin: EdgeInsets.only(top: 15, left: 11, bottom: 49),
                        child: Column(
                          children: [
                            ...course.requirements
                                .map((course) => Container(
                                      margin: EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 10,
                                              height: 16,
                                              child: FittedBox(
                                                child: SvgPicture.asset(
                                                    course["image"]!),
                                              )),
                                          SizedBox(
                                            width: 11,
                                          ),
                                          Text(course["title"]!)
                                        ],
                                      ),
                                    ))
                                .toList()
                          ],
                        )),
                    Heading(heading: "About Instructor"),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 49),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                child: Image.asset(
                                    "assets/images/profile_image.png"),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course.aboutInstructor["name"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    course.aboutInstructor["qualification"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color:
                                            Color.fromRGBO(115, 115, 115, 1)),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          height: 14,
                                          child: SvgPicture.asset(
                                              "assets/images/twitter.svg")),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                          height: 14,
                                          child: SvgPicture.asset(
                                              "assets/images/linkedin.svg")),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                          height: 14,
                                          child: SvgPicture.asset(
                                              "assets/images/facebook.svg")),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: 16,
                            height: 16,
                            child: FittedBox(
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Heading(heading: "Tags"),
                    Row(
                      children: [
                        ...course.tags
                            .map((cor) => Tags(tagName: cor))
                            .toList(),
                      ],
                    ),
                    SizedBox(
                      height: 150,
                    )
                  ],
                ),
              )),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 30),
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: CustomButton(
              buttonText: user.enrolledCourseIds.contains(id)
                  ? "GO TO YOUR COURSE"
                  : "ENROLL NOW",
              onTap: () {
                if (user.enrolledCourseIds.contains(id)) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Dashboard.routeName, (route) => false);
                  Provider.of<NavigationBarHandler>(context, listen: false)
                      .selectPage(1);
                } else {
                  if (course.isFree == true) {
                    Provider.of<Users>(context, listen: false)
                        .setIsEnrolled(id, true);
                    Navigator.of(context).pushNamed(
                        EnrollmentSuccessScreen.routeName,
                        arguments: id);
                  } else {
                    Provider.of<Users>(context, listen: false)
                        .setIsEnrolled(id, true);

                    Navigator.of(context)
                        .pushNamed(CheckoutScreen.routeName, arguments: id);
                  }
                }
              },
              isEnable: true,
            ),
          ),
        ],
      ),
    );
  }
}
