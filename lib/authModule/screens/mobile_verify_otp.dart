import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../widgets/custom_button.dart';

class MobileVerifyOtp extends StatelessWidget {
  static const routeName = "/mobile-verify-otp";

  const MobileVerifyOtp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dewiceH = MediaQuery.of(context).size.height;
    final dewiceW = MediaQuery.of(context).size.width;
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
            padding: EdgeInsets.symmetric(horizontal: 24),
            height: dewiceH,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 17.5,
                        height: 20,
                        child: FittedBox(
                            child: SvgPicture.asset("assets/images/back.svg")),
                      ),
                    )),
                Container(
                    height: 80,
                    width: 98,
                    margin: EdgeInsets.only(
                      bottom: 40,
                    ),
                    child: Image.asset(
                      "assets/images/mobile_03.png",
                      fit: BoxFit.cover,
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 38),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mobile Verification",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            height: 2.4),
                      ),
                      Text(
                        "Please enter the 6-digit code sent to you on",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            height: 1.6,
                            color: Color.fromRGBO(115, 115, 115, 1)),
                      ),
                      Text(
                        "+91 9898989898",
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
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  onChanged: (String value) {},
                  keyboardType: TextInputType.phone,
                  pinTheme: PinTheme(
                      inactiveColor: Colors.black,
                      activeColor: Theme.of(context).primaryColor),
                  cursorColor: Theme.of(context).primaryColor,
                ),
                Container(
                  margin: EdgeInsets.only(top: 23, bottom: 16),
                  alignment: Alignment.center,
                  child: CustomButton(
                      buttonText: "CONTINUE", onTap: () {}, isEnable: true),
                ),
                Container(
                  child: Text("Didn’t get it? Resend in 00:15"),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5),
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
        ),
      ),
    );
  }
}
