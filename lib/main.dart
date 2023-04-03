import 'package:flutter/material.dart';
import 'package:mmt_courses/authModule/providers/users.dart';
import 'package:mmt_courses/homeModule/providers/cart.dart';
import 'package:mmt_courses/homeModule/providers/courses.dart';
import 'package:mmt_courses/homeModule/providers/navigatioBarHandler.dart';
import 'package:mmt_courses/homeModule/providers/quizzes.dart';
import 'package:mmt_courses/homeModule/screens/checkout_screen.dart';
import 'package:mmt_courses/homeModule/screens/detail_page_screen.dart';
import 'package:mmt_courses/homeModule/screens/enrolled_screen.dart';
import 'package:mmt_courses/homeModule/screens/enrollment_success_screen.dart';
import 'package:mmt_courses/homeModule/screens/my_course_screen.dart';
import 'package:mmt_courses/homeModule/screens/quiz_attempt_screen.dart';
import 'package:mmt_courses/homeModule/screens/quiz_instruction_screen.dart';
import 'package:provider/provider.dart';

import '/authModule/providers/images.dart';
import '/authModule/screens/mobile_get_otp_screen.dart';
import '/authModule/screens/mobile_verify_otp_screen.dart';
import '/authModule/screens/profile_details_screen.dart';
import 'authModule/screens/get_started_screen.dart';
import 'homeModule/screens/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Images()),
        ChangeNotifierProvider(create: (ctx) => Users()),
        ChangeNotifierProvider(create: (ctx) => Courses()),
        ChangeNotifierProvider(create: (ctx) => NavigationBarHandler()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Quizzes())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Montserrat",
          primaryColor: const Color.fromRGBO(49, 153, 216, 1),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(secondary: Colors.white),
        ),
        routes: {
          GetStartedScreen.routeName: (ctx) => GetStartedScreen(),
          MobileGetOtpScreen.routeName: (ctx) => MobileGetOtpScreen(),
          MobileVerifyOtpScreen.routeName: (ctx) => MobileVerifyOtpScreen(),
          Dashboard.routeName: (ctx) => Dashboard(),
          ProfileDetailsScreen.routeName: (ctx) => ProfileDetailsScreen(),
          DetailPageScreen.routeName: (ctx) => DetailPageScreen(),
          EnrollmentSuccessScreen.routeName: (ctx) => EnrollmentSuccessScreen(),
          EnrolledScreen.routeName: (ctx) => EnrolledScreen(),
          MyCourseScreen.routeName: (ctx) => MyCourseScreen(),
          CheckoutScreen.routeName: (ctx) => CheckoutScreen(),
        },
        //To pass arguments in constructor
        onGenerateRoute: (settings) {
          if (settings.name == QuizInstructionScreen.routeName) {
            String id = settings.arguments as String;
            return MaterialPageRoute(
                builder: (_) => QuizInstructionScreen(
                      id: id,
                    ));
          }
          if (settings.name == QuizAttemptScreen.routeName) {
            String id = settings.arguments as String;
            return MaterialPageRoute(
                builder: (_) => QuizAttemptScreen(
                      id: id,
                    ));
          }
        },
      ),
    );
  }
}
