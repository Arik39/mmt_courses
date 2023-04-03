import 'package:flutter/material.dart';
import 'package:mmt_courses/common_widgets/custom_background_container.dart';
import 'package:provider/provider.dart';

import '../models/quiz.dart';
import '../providers/quizzes.dart';

class QuizAttemptScreen extends StatefulWidget {
  final String id;
  static const routeName = "/quiz-attempt";

  const QuizAttemptScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<QuizAttemptScreen> createState() => _QuizAttemptScreenState();
}

class _QuizAttemptScreenState extends State<QuizAttemptScreen> {
  bool isNext = true;
  bool isPrevious = false;
  Quiz quiz = Quiz(
      title: "", timer: "", noOfQuestions: 0, questions: [], isSelected: []);
  PageController _pageController = PageController(
    initialPage: 0,
  );

  int score = 0;
  bool isCorrect = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quiz =
        Provider.of<Quizzes>(context, listen: false).fetchQuizById(widget.id);
    for (int i = 0; i <= quiz.questions.length; i++) {
      quiz.isSelected.add([false, false, false, false]);
    }
  }

  void selected(int i, index) {
    for (int k = 0; k < 4; k++) {
      quiz.isSelected![index][k] = false;
    }
    quiz.isSelected![index][i] = true;
    //
    // if (quiz.questions[index]['correctAns'] == i) {
    //   isCorrect = true;
    // } else {
    //   isCorrect = false;
    // }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final deviceW = MediaQuery.of(context).size.width;
    final deviceH = MediaQuery.of(context).size.height;
    quiz = Provider.of<Quizzes>(context).fetchQuizById(widget.id);

    return CustomBackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: deviceH * .10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          flexibleSpace: Container(
            padding: EdgeInsets.only(top: 0, left: 24, right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.pause_circle_outline_rounded,
                      size: 40,
                      color: Color.fromRGBO(115, 115, 115, 1),
                    ),
                    Text(
                      "04:10",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(36, 36, 36, 1),
                      ),
                    ),
                    Text(
                      "SUBMIT",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(238, 97, 97, 1),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            SafeArea(
              child: PageView.builder(
                onPageChanged: (page) {
                  if (page == quiz.questions.length - 1) {
                    isNext = false;
                    isPrevious = true;
                  } else if (page == 0) {
                    isNext = true;
                    isPrevious = false;
                  } else {
                    isNext = true;
                    isPrevious = true;
                  }
                  setState(() {});
                },
                controller: _pageController,
                physics: BouncingScrollPhysics(),
                itemCount: quiz.questions.length,
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      padding: EdgeInsets.only(top: 46, bottom: 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 100),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "QUESTION - " +
                                      (index >= 9
                                          ? (index + 1).toString()
                                          : "0" + (index + 1).toString()) +
                                      " / " +
                                      quiz.questions.length.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: Color.fromRGBO(115, 115, 115, 1),
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Text(
                                  quiz.questions[index]['question'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 500,
                            child: ListView.builder(
                              itemCount: 4,
                              itemBuilder: (BuildContext context, int i) =>
                                  GestureDetector(
                                onTap: () => selected(i, index),
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  decoration: BoxDecoration(
                                    boxShadow: quiz.isSelected[index][i]
                                        ? [
                                            BoxShadow(
                                                color: Color.fromRGBO(
                                                    49, 153, 216, .3),
                                                blurRadius: 5,
                                                offset: Offset(0, 0),
                                                spreadRadius: 1)
                                          ]
                                        : [],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: quiz.isSelected[index][i]
                                        ? Border.all(
                                            color:
                                                Color.fromRGBO(49, 153, 216, 1),
                                            width: 2,
                                          )
                                        : null,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Color.fromRGBO(
                                                224, 239, 249, 1)),
                                        child: Text(
                                          ["A", "B", "C", "D"][i],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        quiz.questions[0]['options'][i],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
                padding: EdgeInsets.only(bottom: 30),
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    !isPrevious
                        ? Text(
                            "Previous",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(67, 67, 67, 1)),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              _pageController.previousPage(
                                  duration: Duration(milliseconds: 250),
                                  curve: Curves.easeInOut);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              child: Text(
                                "Previous",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            style: ButtonStyle(
                                elevation: MaterialStatePropertyAll(4),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                backgroundColor: MaterialStatePropertyAll(
                                    Theme.of(context).colorScheme.secondary)),
                          ),
                    !isNext
                        ? Text(
                            "Next",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(67, 67, 67, 1)),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              _pageController.nextPage(
                                  duration: Duration(milliseconds: 250),
                                  curve: Curves.easeInOut);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            style: ButtonStyle(
                                elevation: MaterialStatePropertyAll(4),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                backgroundColor: MaterialStatePropertyAll(
                                    Theme.of(context).colorScheme.secondary)),
                          ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
