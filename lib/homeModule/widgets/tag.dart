import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  const Tags({Key? key, required this.tagName}) : super(key: key);

  final String tagName;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, top: 11),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        tagName,
        style: TextStyle(
            fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),
      ),
    );
  }
}
