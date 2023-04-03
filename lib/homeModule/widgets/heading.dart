import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String heading;

  const Heading({
    super.key,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
    );
  }
}
