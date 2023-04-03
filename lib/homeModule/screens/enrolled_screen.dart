import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mmt_courses/common_widgets/custom_background_container.dart';
import 'package:mmt_courses/homeModule/providers/courses.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../widgets/module_tile.dart';

class EnrolledScreen extends StatefulWidget {
  static const routeName = "/enrolled";

  const EnrolledScreen({Key? key}) : super(key: key);

  @override
  State<EnrolledScreen> createState() => _EnrolledScreenState();
}

class _EnrolledScreenState extends State<EnrolledScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final course = Provider.of<Courses>(context).fetchByCourseId(id);
    return CustomBackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
                      onTap: () {},
                      child: SvgPicture.asset("assets/images/share.svg")),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "STOCK MARKET",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                course.title,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
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
                          child: SvgPicture.asset("assets/images/star.svg")),
                      Text(
                        "4.8 (1200+ enrolls)",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 1),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          "ENROLLED",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
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
                        course.moduleLevel,
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
              Container(
                margin: EdgeInsets.only(top: 31, bottom: 40),
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
                          child: Image.asset("assets/images/profile_image.png"),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.aboutInstructor['name'],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              course.aboutInstructor['qualification'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color.fromRGBO(115, 115, 115, 1)),
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
              Text(
                "MODULES",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  ModuleTile(index: 01, title: "Welcome Session"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
