import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mmt_courses/authModule/providers/users.dart';
import 'package:mmt_courses/authModule/screens/mobile_get_otp_screen.dart';
import 'package:mmt_courses/common_widgets/custom_background_container.dart';
import 'package:provider/provider.dart';

import '../../homeModule/screens/dashboard.dart';
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

  LocalStorage storage = LocalStorage("TusharGhone");

  myInit() async {
    await storage.ready;
    var data = storage.getItem("accessToken");
    print(data);
    if (data != null) {
      data = json.decode(data);
      final response =
          await Provider.of<Users>(context, listen: false).login(data['phone']);
      if (response) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          Dashboard.routeName,
          (route) => false,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    myInit();
  }

  @override
  Widget build(BuildContext context) {
    final image = Provider.of<Images>(context);
    final imgList = image.images;
    final dewiceH = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomBackgroundContainer(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: dewiceH,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 192,
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
                          const SizedBox(
                            height: 20,
                          ),
                          CustomIndicator(
                              imgList: imgList,
                              controller: _controller,
                              current: _current),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Learn to trade \nanytime, anywhere",
                          style: TextStyle(
                              fontSize: 24,
                              color: Color.fromRGBO(67, 67, 67, 1),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 30),
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.symmetric(horizontal: 24),
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
    );
  }
}
