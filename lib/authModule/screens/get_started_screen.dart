import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mmt_courses/authModule/screens/mobile_get_otp_screen.dart';
import 'package:provider/provider.dart';

import '../providers/images.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_indicator.dart';

class GetStartedScreen extends StatefulWidget {
  static const routeName = "/";

  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  int _current = 0;

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final image = Provider.of<Images>(context);
    final imgList = image.images;
    //final dewiceH = MediaQuery.of(context).size.height;
    //final dewiceW = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
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
            margin: EdgeInsets.only(
              bottom: 53,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 54,
                  ),
                  child: CarouselSlider(
                    items: imgList
                        .map((e) => Image.asset(
                              e,
                              scale: 2,
                              fit: BoxFit.cover,
                            ))
                        .toList(),
                    options: CarouselOptions(
                        height: 192,
                        viewportFraction: 1,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                    carouselController: _controller,
                  ),
                ),
                CustomIndicator(
                    imgList: imgList,
                    controller: _controller,
                    current: _current),
                Container(
                  margin: EdgeInsets.only(left: 63, right: 63, bottom: 49),
                  child: Text(
                    "Learn to trade \nanytime, anywhere",
                    style: TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(67, 67, 67, 1),
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  alignment: Alignment.center,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: CustomButton(
                    buttonText: "START LEARNING",
                    onTap: () => Navigator.of(context)
                        .pushNamed(MobileGetOtpScreen.routeName),
                    isEnable: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
