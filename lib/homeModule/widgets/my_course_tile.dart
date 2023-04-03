import 'package:flutter/material.dart';

import '../screens/enrolled_screen.dart';

class MyCourseTile extends StatelessWidget {
  final bool isStarted;
  final double courseCompletionPctOfTotal;
  final String title;
  final String id;
  final String imgPath;

  const MyCourseTile(
      {Key? key,
      required this.isStarted,
      required this.courseCompletionPctOfTotal,
      required this.title,
      required this.id,
      required this.imgPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceW = MediaQuery.of(context).size.width;
    final deviceH = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          // height: deviceH * .1,
          // width: deviceW * .26,
          height: 72,
          width: 80,
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(right: 16, top: 12),
          child: Image.asset(
            imgPath,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Container(
            height: 72,
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
                isStarted
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 1,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromRGBO(115, 115, 115, 1)),
                                ),
                                FractionallySizedBox(
                                  heightFactor: 4,
                                  widthFactor: courseCompletionPctOfTotal,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            (courseCompletionPctOfTotal * 100)
                                    .toStringAsFixed(0) +
                                "%",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 10),
                          )
                        ],
                      )
                    : Text(
                        "START NOW",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 10),
                      )
              ],
            ),
          ),
        ),
        Container(
          child: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EnrolledScreen.routeName, arguments: id);
            },
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }
}
