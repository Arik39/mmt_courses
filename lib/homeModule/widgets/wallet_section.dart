import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mmt_courses/homeModule/providers/cart.dart';
import 'package:provider/provider.dart';

class WalletSection extends StatefulWidget {
  WalletSection({
    super.key,
  });

  @override
  State<WalletSection> createState() => _WalletSectionState();
}

class _WalletSectionState extends State<WalletSection> {
  bool isEnable = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset("assets/images/wallet.svg"),
            SizedBox(
              width: 10,
            ),
            Text(
              "Use Wallet :",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
            ),
            Text(
              "₹" + cart.fetchWalletAmount().toStringAsFixed(2),
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
        Checkbox(
          value: cart.fetchWalletUsed(),
          onChanged: (value) {
            Provider.of<Cart>(context, listen: false)
                .setWallet(!cart.fetchWalletUsed());
          },
          side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          activeColor: Theme.of(context).primaryColor,
        )
      ],
    );
  }
}
