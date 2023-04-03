import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/courses.dart';

class CheckoutTile extends StatelessWidget {
  const CheckoutTile({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final course = Provider.of<Courses>(context).fetchByCourseId(id);
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(top: 16, right: 12),
          height: 80,
          width: 112,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Image.asset(
            course.image,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 4),
            alignment: Alignment.center,
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 4),
                        height: 10,
                        width: 10,
                        child: SvgPicture.asset("assets/images/star.svg")),
                    Text(
                      "4.8 (1200+ enrolls)",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                  ],
                ),
                Text(
                  "₹" + course.discountedPrice.toString(),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
