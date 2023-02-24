import 'package:flutter/material.dart';
import 'package:mmt_courses/authModule/providers/images.dart';
import 'package:mmt_courses/authModule/screens/mobile_get_otp_screen.dart';
import 'package:mmt_courses/authModule/screens/mobile_verify_otp.dart';
import 'package:provider/provider.dart';

import 'authModule/screens/get_started_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Images(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(49, 153, 216, 1),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(secondary: Colors.white),
        ),
        routes: {
          GetStartedScreen.routeName: (ctx) => GetStartedScreen(),
          MobileGetOtpScreen.routeName: (ctx) => MobileGetOtpScreen(),
          MobileVerifyOtp.routeName: (ctx) => MobileVerifyOtp(),
        },
      ),
    );
  }
}
