import 'package:flutter/material.dart';

class HelpVideoTile extends StatelessWidget {
  final String image;
  final String title;
  const HelpVideoTile({Key? key, required this.image, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24),
      child: Column(
        children: [
          Container(
              height: 88,
              width: 144,
              child: FittedBox(child: Image.asset(image))),
          Container(
            padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 4),
            width: 144,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            width: 144,
            child: Text(
              "2 min",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
