import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function onTap;
  final bool isEnable;

  const CustomButton(
      {super.key,
      required this.buttonText,
      required this.onTap,
      required this.isEnable});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isEnable ? () => onTap() : null,
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).primaryColor,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700),
        ),
        style: ButtonStyle(
            elevation: isEnable ? MaterialStatePropertyAll(4) : null,
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.secondary)),
      ),
    );
  }
}
