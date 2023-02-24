import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mmt_courses/authModule/widgets/custom_button.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'mobile_verify_otp.dart';

class MobileGetOtpScreen extends StatelessWidget {
  static const routeName = "/mobile-get-otp";

  const MobileGetOtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.0, 0.0),
              end: Alignment(0.199, .98),
              colors: [
                Color.fromRGBO(251, 255, 244, 1),
                Color.fromRGBO(152, 204, 236, 1)
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: 17.5,
                      height: 20,
                    ),
                  ),
                  Container(
                      height: 80,
                      width: 98,
                      margin: EdgeInsets.only(bottom: 39),
                      child: Image.asset(
                        "assets/images/mobile_01.png",
                        fit: BoxFit.cover,
                      )),
                  Container(
                    margin: EdgeInsets.only(bottom: 59),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mobile Number",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              height: 2.4),
                        ),
                        Text(
                          "Enter your mobile number to proceed",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              height: 1.6,
                              color: Color.fromRGBO(115, 115, 115, 1)),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                        counter: Container(),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child:
                              SvgPicture.asset("assets/images/mobile_02.svg"),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(36, 36, 36, 1),
                                width: 1)),
                        hintText: "Enter your mobile number",
                        hintStyle: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color.fromRGBO(115, 115, 115, 1),
                        ),
                        hintMaxLines: 1),
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Color.fromRGBO(115, 115, 115, 1)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 23, bottom: 16),
                    alignment: Alignment.center,
                    child: CustomButton(
                        buttonText: "GET OTP",
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(MobileVerifyOtp.routeName);
                        },
                        isEnable: true),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 52, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Divider(
                          color: Color.fromRGBO(115, 115, 115, 1),
                          endIndent: 8,
                          height: .5,
                        )),
                        Text("OR"),
                        Expanded(
                            child: Divider(
                          color: Color.fromRGBO(115, 115, 115, 1),
                          indent: 8,
                          height: .5,
                        ))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/google.svg"),
                      SizedBox(
                        width: 42,
                      ),
                      SvgPicture.asset("assets/images/apple.svg"),
                      SizedBox(
                        width: 42,
                      ),
                      SvgPicture.asset("assets/images/facebook.svg")
                    ],
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
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
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
