import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  double price = 0;
  double wallet = 245.00;
  bool isWallet = false;

  double totalGst(double price) {
    return (price * 18.0) / 100.0;
  }

  double fetchWalletAmount() {
    return wallet;
  }

  bool fetchWalletUsed() {
    return isWallet;
  }

  void setWallet(bool a) {
    isWallet = a;
    notifyListeners();
  }

  double totalToPay(double price) {
    return isWallet
        ? (price + ((price * 18.0) / 100.0)) - wallet
        : price + ((price * 18.0) / 100.0);
  }
}
