import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mmt_courses/authModule/providers/users.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final name = Provider.of<Users>(context).fetchUser().name;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome,",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                name!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          Row(
            children: [
              SvgPicture.asset("assets/images/search.svg"),
              SizedBox(
                width: 24,
              ),
              SvgPicture.asset("assets/images/google.svg"),
              SizedBox(
                width: 24,
              ),
              SvgPicture.asset("assets/images/notification.svg"),
            ],
          )
        ],
      ),
    );
  }
}
