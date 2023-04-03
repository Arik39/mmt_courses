import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../homeModule/screens/dashboard.dart';
import '../models/user.dart';
import '../providers/users.dart';
import '/common_widgets/custom_background_container.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../screens/profile_details_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_footer.dart';

class MobileVerifyOtpScreen extends StatelessWidget {
  static const routeName = "/mobile-verify-otp";

  MobileVerifyOtpScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mobileNumber =
        Provider.of<Users>(context, listen: false).fetchUser().mobileNumber;
    Future<void> _saveForm() async {
      final isValid = _formKey.currentState!.validate();

      if (!isValid) {
        return;
      }

      bool isAccFound =
          await Provider.of<Users>(context, listen: false).login(mobileNumber!);
      print(isAccFound);
      if (isAccFound) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          Dashboard.routeName,
          (route) => false,
        );
      } else {
        Navigator.of(context).pushNamed(ProfileDetailsScreen.routeName);
      }
    }

    String? _validateOTP(String value) {
      if (value.isEmpty) {
        return "Please enter OTP";
      } else if (value.length < 6) {
        return "Please Enter the valid OTP ";
      } else {
        return null;
      }
    }

    final deviceH = MediaQuery.of(context).size.height;
    final deviceW = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: CustomBackgroundContainer(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: deviceH,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.only(top: 50),
                          width: 17.5,
                          height: 20,
                          child: FittedBox(
                              child:
                                  SvgPicture.asset("assets/images/back.svg")),
                        ),
                      )),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                      height: 80,
                      width: 98,
                      margin: const EdgeInsets.only(
                        bottom: 40,
                      ),
                      child: Image.asset(
                        "assets/images/mobile_02.png",
                        fit: BoxFit.cover,
                      )),
                  Container(
                    margin: const EdgeInsets.only(bottom: 38),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Mobile Verification",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              height: 2.4),
                        ),
                        const Text(
                          "Please enter the 6-digit code sent to you on",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              height: 1.6,
                              color: Color.fromRGBO(115, 115, 115, 1)),
                        ),
                        Text(
                          "+91 $mobileNumber",
                          style: const TextStyle(
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
                    autoDismissKeyboard: true,
                    appContext: context,
                    length: 6,
                    onChanged: (String value) {},
                    validator: (value) => _validateOTP(value!),
                    keyboardType: TextInputType.phone,
                    pinTheme: PinTheme(
                        inactiveColor: Colors.black,
                        activeColor: Theme.of(context).primaryColor),
                    cursorColor: Theme.of(context).primaryColor,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 23, bottom: 16),
                    alignment: Alignment.center,
                    child: CustomButton(
                        buttonText: "CONTINUE",
                        onTap: _saveForm,
                        isEnable: true),
                  ),
                  Container(
                    child: const Text("Didn’t get it? Resend in 00:15"),
                  ),
                  const Expanded(
                    flex: 5,
                    child: CustomFooter(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
