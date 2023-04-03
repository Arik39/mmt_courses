import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mmt_courses/common_widgets/custom_background_container.dart';
import 'package:mmt_courses/homeModule/providers/cart.dart';
import 'package:mmt_courses/homeModule/providers/courses.dart';
import 'package:mmt_courses/homeModule/screens/enrollment_success_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/checkout_tile.dart';
import '../widgets/wallet_section.dart';

class CheckoutScreen extends StatelessWidget {
  static const routeName = "/checkout";
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final course = Provider.of<Courses>(context).fetchByCourseId(id);
    final cart = Provider.of<Cart>(context);

    return CustomBackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            margin: EdgeInsets.only(left: 24, top: 50),
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: SvgPicture.asset("assets/images/back.svg"),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, top: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cart Items",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              CheckoutTile(id: id),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/images/delete.svg"),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Remove",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 10),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/images/bookmark_rounded.svg"),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Move to Wishlist",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/images/offer.svg"),
                      SizedBox(
                        width: 11,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Offer available",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Text(
                            "Add Promocode",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 10),
                          )
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Theme.of(context).primaryColor,
                      ))
                ],
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 60), child: WalletSection()),
              Text(
                "Order Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Items total",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                          Text(
                            "₹" + course.discountedPrice.toStringAsFixed(2),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total GST (18%)",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                          Text(
                            "₹" +
                                cart
                                    .totalGst(course.discountedPrice)
                                    .toStringAsFixed(2),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Wallet used",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                          Text(
                            "-₹" +
                                (cart.fetchWalletUsed()
                                    ? cart
                                        .fetchWalletAmount()
                                        .toStringAsFixed(2)
                                    : "0.00"),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  )),
              Divider(
                thickness: 1,
                color: Color.fromRGBO(67, 67, 67, 1),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 35),
                padding: EdgeInsets.only(left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "To Pay",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Text(
                      "₹" +
                          cart
                              .totalToPay(course.discountedPrice)
                              .toStringAsFixed(2),
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 8, right: 30),
                child: Text(
                  "By completing your purchase you agree to these Terms of services.",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                      EnrollmentSuccessScreen.routeName,
                      arguments: id);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 84),
                  padding: EdgeInsets.only(left: 24),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total:",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            "₹" +
                                cart
                                    .totalToPay(course.discountedPrice)
                                    .toStringAsFixed(2),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "CHECKOUT",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Theme.of(context).primaryColor),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Theme.of(context).primaryColor,
                                size: 16,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
