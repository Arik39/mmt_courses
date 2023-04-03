import 'package:flutter/material.dart';
import 'package:mmt_courses/common_widgets/custom_background_container.dart';
import 'package:mmt_courses/common_widgets/custom_carousel_with_indicator.dart';
import 'package:mmt_courses/homeModule/providers/quizzes.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/custom_appbar.dart';
import '../models/quiz.dart';
import '../providers/courses.dart';
import '../widgets/CustomCourses.dart';
import '../widgets/custom_quiz_tile.dart';
import '../widgets/help_video_tile.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<String> imgList = [
    "assets/images/dashboard_01.png",
    "assets/images/dashboard_02.png",
    "assets/images/dashboard_03.png",
  ];
  List<Quiz> quiz = [];

  bool isLoading = false;

  fetchCourses() async {
    try {
      setState(() => isLoading = true);

      await Provider.of<Courses>(context, listen: false).getAllCourses();
    } catch (e) {
      print(e);
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  fetchQuiz() async {
    try {
      setState(() => isLoading = true);

      await Provider.of<Quizzes>(context, listen: false).getAllQuiz();
    } catch (e) {
      print(e);
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCourses();
    fetchQuiz();
    quiz = Provider.of<Quizzes>(context, listen: false).fecthAllQuiz();
  }

  @override
  Widget build(BuildContext context) {
    quiz = Provider.of<Quizzes>(context).fecthAllQuiz();
    /* print(quiz
        .map((quiz) => CustomQuizTile(
              isCompleted: true,
              title: quiz.title,
              timer: quiz.timer,
              id: quiz.id!,
            ))
        .toList()
        .toString());*/
    return CustomBackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          flexibleSpace: CustomAppBar(),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 36, bottom: 56),
                        child: CustomCarouselWithIndicator(
                            imgList: imgList)), //CustomCarouselWithIndicator

                    Container(
                      margin: EdgeInsets.only(left: 24, right: 24, bottom: 14),
                      child: Text(
                        "Continue Learning",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 24, right: 24, bottom: 56),
                      padding: EdgeInsets.only(
                          top: 11, left: 16, bottom: 13, right: 25),
                      height: 64,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Money Making Trading Course",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  "5 / 20 Modules",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              )
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
                          )
                        ],
                      ),
                    ),

                    CustomCourses(
                      isFree: true,
                    ),
                    SizedBox(
                      height: 56,
                    ),
                    CustomCourses(
                      isFree: false,
                    ),
                    SizedBox(
                      height: 56,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 14),
                      margin: EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Quiz",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "see all",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      height: 200,
                      child: GridView(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 144,
                          childAspectRatio: 144 / 88,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                        ),
                        children: quiz
                            .map((quiz) => CustomQuizTile(
                                  isCompleted: true,
                                  title: quiz.title,
                                  timer: quiz.timer,
                                  id: quiz.id!,
                                ))
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 14),
                      margin: EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Help Videos",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "see all",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            HelpVideoTile(
                              image: "assets/images/help_01.png",
                              title: "How to buy a free course?",
                            ),
                            HelpVideoTile(
                              image: "assets/images/help_02.png",
                              title: "How to Refer and Earn?",
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
