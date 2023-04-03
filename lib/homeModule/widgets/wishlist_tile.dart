import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mmt_courses/authModule/models/user.dart';
import 'package:mmt_courses/authModule/providers/users.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';

class WishlistTile extends StatefulWidget {
  final Course course;
  final bool isSelectedMenuEnable;
  final Function addOrRemoveItem;
  final List<String> selectedCourseId;

  WishlistTile(
      {Key? key,
      required this.course,
      required this.isSelectedMenuEnable,
      required this.addOrRemoveItem,
      required this.selectedCourseId})
      : super(key: key);

  @override
  State<WishlistTile> createState() => _WishlistTileState();
}

class _WishlistTileState extends State<WishlistTile> {
  late final User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = Provider.of<Users>(context, listen: false).fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    final deviceW = MediaQuery.of(context).size.width;
    final deviceH = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.isSelectedMenuEnable,
          child: Container(
            child: Checkbox(
              fillColor:
                  MaterialStatePropertyAll(Theme.of(context).primaryColor),
              value: widget.selectedCourseId.contains(widget.course.id),
              onChanged: (bool? value) {
                widget.addOrRemoveItem(widget.course.id);
              },
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(right: 12),
          height: deviceH * .09,
          width: !widget.isSelectedMenuEnable ? deviceW * 0.3 : deviceW * .2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Image.asset(widget.course.image),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: deviceW * .4,
                  child: Text(
                    widget.course.title,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                Visibility(
                  visible: !widget.isSelectedMenuEnable,
                  child: GestureDetector(
                    onTap: () async {
                      await Provider.of<Users>(context, listen: false)
                          .isWishlist(widget.course.id!);
                    },
                    child: Icon(
                        user.wishlistCourseIds.contains(widget.course.id)
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded),
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 4),
                      height: 16,
                      width: 17.45,
                      child: SvgPicture.asset("assets/images/star.svg")),
                  Text(
                    "4.8 (1200+ enrolls)",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              width: deviceW * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.course.discountedPrice == ""
                        ? "FREE"
                        : "₹" + widget.course.discountedPrice.toString(),
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  Visibility(
                    visible: !widget.isSelectedMenuEnable,
                    child: Container(
                      height: 27,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "BUY NOW",
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700),
                        ),
                        style: ButtonStyle(
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8)),
                            elevation: MaterialStatePropertyAll(4),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.secondary)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
