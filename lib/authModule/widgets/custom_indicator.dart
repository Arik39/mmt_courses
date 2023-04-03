import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    super.key,
    required this.imgList,
    required CarouselController controller,
    required int current,
  })  : _controller = controller,
        _current = current;

  final List<String> imgList;
  final CarouselController _controller;
  final int _current;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.asMap().entries.map((entry) {
          return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: _current == entry.key ? 16 : 8,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: _current == entry.key
                      ? BoxShape.rectangle
                      : BoxShape.circle,
                  borderRadius:
                      _current == entry.key ? BorderRadius.circular(10) : null,
                  color: _current == entry.key
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                ),
              ));
        }).toList(),
      ),
    );
  }
}
