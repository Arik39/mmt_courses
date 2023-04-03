import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../authModule/widgets/custom_indicator.dart';

class CustomCarouselWithIndicator extends StatefulWidget {
  final List<String> imgList;
  const CustomCarouselWithIndicator({Key? key, required this.imgList})
      : super(key: key);

  @override
  State<CustomCarouselWithIndicator> createState() =>
      _CustomCarouselWithIndicatorState();
}

class _CustomCarouselWithIndicatorState
    extends State<CustomCarouselWithIndicator> {
  int _current = 0;

  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.imgList
              .map((e) => Image.asset(
                    e,
                    fit: BoxFit.cover,
                  ))
              .toList(),
          options: CarouselOptions(
              height: 170,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
          carouselController: _controller,
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: CustomIndicator(
              imgList: widget.imgList,
              controller: _controller,
              current: _current),
        ),
      ],
    );
  }
}
