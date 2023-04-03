import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mmt_courses/authModule/widgets/custom_button.dart';
import 'package:mmt_courses/homeModule/screens/dashboard.dart';
import 'package:provider/provider.dart';

import '../providers/navigatioBarHandler.dart';

class EnrollmentSuccessScreen extends StatelessWidget {
  static const routeName = "/enrollment-success";
  const EnrollmentSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final deviceH = MediaQuery.of(context).size.height;
    final deviceW = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 21, right: 21),
          child: Stack(
            children: [
              Container(
                height: deviceH,
                width: deviceW,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage("assets/images/Confetti.png"),
                        scale: 2,
                        fit: BoxFit.contain)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/success.svg"),
                    SizedBox(
                      height: 37,
                    ),
                    Text(
                      "PAYMENT SUCCESSFUL",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 49),
                      child: Text(
                        "Some text line to appreciate and motivate the user briefly in one or two lines.",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 24),
                child: CustomButton(
                    buttonText: "LETS GET STARTED",
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Dashboard.routeName, (route) => false);
                      Provider.of<NavigationBarHandler>(context, listen: false)
                          .selectPage(1);
                    },
                    isEnable: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
