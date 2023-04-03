import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mmt_courses/homeModule/screens/quiz_instruction_screen.dart';

class CustomQuizTile extends StatelessWidget {
  final bool isCompleted;
  final String title;
  final String timer;
  final String id;

  const CustomQuizTile({
    super.key,
    required this.isCompleted,
    required this.title,
    required this.timer,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(QuizInstructionScreen.routeName, arguments: id),
      child: Container(
        height: 88,
        width: 144,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 12,
                top: 12,
                bottom: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      Text(
                        timer,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 10),
                      ),
                    ],
                  ),
                  SvgPicture.asset(isCompleted
                      ? "assets/images/correct_circle.svg"
                      : "assets/images/forward_arrow.svg")
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(right: 12, bottom: 8),
                height: 48,
                width: 52.57,
                child: FittedBox(child: Image.asset("assets/images/quiz.png")))
          ],
        ),
      ),
    );
  }
}
