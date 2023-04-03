import 'package:flutter/material.dart';

class NavigationBarHandler with ChangeNotifier {
  int _selectedPageIndex = 0;

  void selectPage(int index) {
    _selectedPageIndex = index;
    notifyListeners();
  }

  int selectedPageIndexGetter() {
    return _selectedPageIndex;
  }
}
