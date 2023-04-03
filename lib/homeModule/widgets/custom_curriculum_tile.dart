import 'package:flutter/material.dart';

class CustomCurriculumTile extends StatefulWidget {
  final String title;

  CustomCurriculumTile({Key? key, required this.title}) : super(key: key);

  @override
  State<CustomCurriculumTile> createState() => _CustomCurriculumTileState();
}

class _CustomCurriculumTileState extends State<CustomCurriculumTile> {
  bool ishide = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      ishide = !ishide;
                    });
                  },
                  child: !ishide
                      ? Icon(Icons.keyboard_arrow_down_rounded)
                      : Icon(Icons.keyboard_arrow_up_rounded))
            ],
          ),
        ),
        AnimatedOpacity(
          opacity: ishide ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: Visibility(
            visible: ishide,
            child: Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(text: "\u2022 How to access the MMTC Course"),
                      TextSpan(
                          text: "\n\u2022 How to get connected to community"),
                      TextSpan(text: "\n\u2022 How to complete the course?"),
                    ],
                    style: TextStyle(
                        color: Color.fromRGBO(67, 67, 67, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  )),
            ),
          ),
        )
      ],
    );
  }
}
