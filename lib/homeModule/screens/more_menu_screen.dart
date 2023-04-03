import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mmt_courses/authModule/models/user.dart';
import 'package:mmt_courses/authModule/screens/get_started_screen.dart';
import 'package:mmt_courses/authModule/screens/profile_details_screen.dart';
import 'package:provider/provider.dart';

import '../../authModule/providers/users.dart';
import '../../common_widgets/custom_background_container.dart';
import '../providers/navigatioBarHandler.dart';

class MoreMenuScreen extends StatefulWidget {
  const MoreMenuScreen({Key? key}) : super(key: key);

  @override
  State<MoreMenuScreen> createState() => _MoreMenuScreenState();
}

class _MoreMenuScreenState extends State<MoreMenuScreen> {
  User user = User(
    name: "",
    imagePath: "",
    birthDate: DateTime.now(),
    gender: "",
    email: "",
    mobileNumber: "",
    wishlistCourseIds: [],
    enrolledCourseIds: [],
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = Provider.of<Users>(context, listen: false).fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<Users>(context).fetchUser();
    final deviceH = MediaQuery.of(context).size.height;
    final deviceW = MediaQuery.of(context).size.width;
    return CustomBackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          flexibleSpace: Container(
            padding: EdgeInsets.only(left: 26, top: 20, right: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset("assets/images/whatsapp.svg"),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "SUPPORT",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 40, right: 40, top: 63),
          physics: BouncingScrollPhysics(),
          child: Container(
            height: deviceH,
            width: deviceW,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/profile_image_02.png",
                                  scale: 2,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.name!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      user.email!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      ProfileDetailsScreen.routeName,
                                      arguments: user.id);
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 62),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/images/blog.svg"),
                                  SizedBox(
                                    width: 19,
                                  ),
                                  Text(
                                    "Blog",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset("assets/images/quiz.svg"),
                                  SizedBox(
                                    width: 19,
                                  ),
                                  Text(
                                    "Quiz",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset("assets/images/wallet.svg"),
                                  SizedBox(
                                    width: 19,
                                  ),
                                  Text(
                                    "Wallet",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset("assets/images/blog.svg"),
                                  SizedBox(
                                    width: 19,
                                  ),
                                  Text(
                                    "Blog",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset("assets/images/blog.svg"),
                                  SizedBox(
                                    width: 19,
                                  ),
                                  Text(
                                    "Blog",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Divider(
                          color: Color.fromRGBO(115, 115, 115, 1),
                          thickness: 1,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Connect with us",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      "assets/images/facebook.svg"),
                                  SizedBox(
                                    width: 28,
                                  ),
                                  SvgPicture.asset("assets/images/google.svg"),
                                  SizedBox(
                                    width: 28,
                                  ),
                                  SvgPicture.asset(
                                      "assets/images/telegram.svg"),
                                  SizedBox(
                                    width: 28,
                                  ),
                                  SvgPicture.asset("assets/images/youtube.svg"),
                                ],
                              ),
                              SizedBox(
                                height: 48,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/images/settings.svg"),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        "Settings",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Provider.of<Users>(context, listen: false)
                                          .logout();
                                      Provider.of<NavigationBarHandler>(context,
                                              listen: false)
                                          .selectPage(0);
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              GetStartedScreen.routeName,
                                              (route) => false);
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/images/logout.svg"),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          "Logout",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
