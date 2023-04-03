import 'package:flutter/material.dart';
import 'package:mmt_courses/authModule/providers/users.dart';
import 'package:mmt_courses/authModule/widgets/custom_button.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:mmt_courses/authModule/widgets/custom_footer.dart';
import 'package:mmt_courses/common_widgets/custom_background_container.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import 'mobile_verify_otp_screen.dart';

class MobileGetOtpScreen extends StatelessWidget {
  static const routeName = "/mobile-get-otp";

  MobileGetOtpScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  late User _user;

  @override
  Widget build(BuildContext context) {
    void _saveForm() {
      final isValid = _formKey.currentState!.validate();

      if (!isValid) {
        return;
      }
      _formKey.currentState!.save();
    }

    String? validateMobile(String value) {
      String pattern = r'([6,7,8,9][0-9]{9})';
      RegExp regExp = RegExp(pattern);
      if (value.isEmpty) {
        return 'Please enter mobile number';
      } else if (!regExp.hasMatch(value)) {
        return 'Please enter valid mobile number';
      }
      return null;
    }

    return Scaffold(
      body: Form(
        key: _formKey,
        child: CustomBackgroundContainer(
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
                  TextFormField(
                    onEditingComplete: _saveForm,
                    maxLines: 1,
                    maxLength: 10,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.phone,
                    validator: (v) => validateMobile(v!),
                    onSaved: (value) async {
                      _user = User(
                        name: null,
                        imagePath: null,
                        birthDate: null,
                        gender: null,
                        email: null,
                        mobileNumber: value!,
                        wishlistCourseIds: [],
                        enrolledCourseIds: [],
                      );

                      Navigator.of(context).pushNamed(
                        MobileVerifyOtpScreen.routeName,
                      );
                      Provider.of<Users>(context, listen: false).addUser(_user);
                    },
                    decoration: InputDecoration(
                        counterText: "",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: SvgPicture.asset("assets/images/mobile.svg"),
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
                        onTap: _saveForm,
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
