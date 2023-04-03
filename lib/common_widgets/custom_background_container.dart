import 'package:flutter/material.dart';

class CustomBackgroundContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? padding;
  const CustomBackgroundContainer({Key? key, this.child, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(251, 255, 244, 1),
            Color.fromRGBO(152, 204, 236, 1)
          ],
        ),
      ),
      child: child,
    );
  }
}
