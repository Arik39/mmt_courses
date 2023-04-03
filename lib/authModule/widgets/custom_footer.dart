import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      alignment: Alignment.bottomCenter,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: "By continuing you agree to the ",
            style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
                fontSize: 10,
                color: Color.fromRGBO(115, 115, 115, 1)),
          ),
          TextSpan(
            text: "Terms of services ",
            style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Color.fromRGBO(115, 115, 115, 1)),
          ),
          TextSpan(
            text: "and ",
            style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
                fontSize: 10,
                color: Color.fromRGBO(115, 115, 115, 1)),
          ),
          TextSpan(
            text: "\nPrivacy policy ",
            style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Color.fromRGBO(115, 115, 115, 1)),
          )
        ]),
      ),
    );
  }
}
