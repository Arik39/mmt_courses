import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mmt_courses/homeModule/models/quiz.dart';
import 'package:mmt_courses/homeModule/providers/quizzes.dart';
import 'package:mmt_courses/homeModule/screens/quiz_attempt_screen.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/custom_background_container.dart';

class QuizInstructionScreen extends StatefulWidget {
  final String id;

  static const routeName = "/quiz-instruction";

  const QuizInstructionScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<QuizInstructionScreen> createState() => _QuizInstructionScreenState();
}

class _QuizInstructionScreenState extends State<QuizInstructionScreen> {
  Quiz quiz = Quiz(
      title: "", timer: "", noOfQuestions: 0, questions: [], isSelected: []);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quiz =
        Provider.of<Quizzes>(context, listen: false).fetchQuizById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final deviceW = MediaQuery.of(context).size.width;
    final deviceH = MediaQuery.of(context).size.height;
    quiz = Provider.of<Quizzes>(context).fetchQuizById(widget.id);
    return CustomBackgroundContainer(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              flexibleSpace: Container(
                padding: EdgeInsets.only(left: 26, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: SvgPicture.asset(
                            "assets/images/back.svg",
                          ),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text(
                          quiz.title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 96, top: 150),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/quiz_enlarged.png",
                        height: deviceH * .15,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "INSTRUCTIONS",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  color: Colors.black,
                                  height: 2),
                              children: [
                                TextSpan(text: "• You have "),
                                TextSpan(
                                    text: quiz.timer[0] + " minutes ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(text: "for this quiz.\n"),
                                TextSpan(text: "• This quiz contains "),
                                TextSpan(
                                    text: quiz.noOfQuestions.toString() +
                                        " questions",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(text: " for 20 marks.\n"),
                                TextSpan(text: "• Each question has "),
                                TextSpan(
                                    text: "4 options",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text:
                                        ". You have to select one correct option."),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 30),
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(QuizAttemptScreen.routeName,
                      arguments: quiz.id);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "START QUIZ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
                style: ButtonStyle(
                    elevation: MaterialStatePropertyAll(4),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.secondary)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
